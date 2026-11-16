"""国土交通省「全国の人流オープンデータ」を取り出す。

配布物は G空間情報センターのデータセット mlit-1km-fromto にある zip で、zip の中に
年月ごとの zip（中身は CSV 1 つ）が入っている。

1. CKAN の API から配布物の一覧を取り、zip を data/people_flow/raw/ に保存する（取得済みで ETag・Last-Modified が変わっていなければ使い回す）
2. 1km メッシュ別（monthly_mdp_mesh1km_<都道府県>）と市区町村単位発地別
   （monthly_fromto_city_<都道府県>）は、都道府県ごとに全年月の CSV を 1 つの Parquet にする
3. 1km メッシュ属性・都道府県市区町村マスタ・地方区分マスタは、年ごとの CSV をそのまま置く

出力:
- data/people_flow/mesh_1km/<都道府県コード>.parquet
- data/people_flow/city_from_area/<都道府県コード>.parquet
- data/people_flow/attribute_<年>.csv
- data/people_flow/prefcode_citycode_master_<年>.csv
- data/people_flow/regioncode_master_<年>.csv
- data/people_flow/source_file.ndjson（取得した zip ごとの記録。fetch_file が返す source_file の行に file を足したもの）

データソース: 「全国の人流オープンデータ」（国土交通省）
https://www.geospatial.jp/ckan/dataset/mlit-1km-fromto
"""

import io
import json
import logging
import os
import re
import tempfile
import time
import zipfile
from pathlib import Path
from urllib.error import HTTPError

import duckdb

from shared.fetch import fetch, fetch_file, replacing, write_atomic

logger = logging.getLogger("pipelines")

PACKAGE_URL = "https://www.geospatial.jp/ckan/api/3/action/package_show?id=mlit-1km-fromto"
USER_AGENT = "dataset-geospatial (+https://github.com/queria-io/dataset-geospatial)"
RAW = Path("data/people_flow/raw")
OUT = Path("data/people_flow")
SOURCE_FILES = OUT / "source_file.ndjson"
# 配布物のファイル名（URL の末尾）→ 出力のフォルダ
MONTHLY = {
    re.compile(r"monthly_mdp_mesh1km_(\d{2})\.zip"): "mesh_1km",
    re.compile(r"monthly_fromto_city_(\d{2})\.zip"): "city_from_area",
}
MASTERS = ("attribute.zip", "prefcodecitycodemaster.zip", "regioncodemaster.zip")
# 内側の CSV の見出し。変わっていたら止める
HEADERS = {
    "mesh_1km": "mesh1kmid,prefcode,citycode,year,month,dayflag,timezone,population",
    "city_from_area": "year,month,dayflag,timezone,prefcode,citycode,from_area,population",
}


def resource_urls() -> list[str]:
    body = fetch(PACKAGE_URL, user_agent=USER_AGENT)
    resources = json.loads(body)["result"]["resources"]
    return [r["url"] for r in resources if r["url"].endswith(".zip")]


def selected(prefecture: str) -> bool:
    """PEOPLE_FLOW_PREFECTURES（カンマ区切り）があればその都道府県だけにする。PR のビルド確認で使う。"""
    wanted = os.environ.get("PEOPLE_FLOW_PREFECTURES")
    return not wanted or prefecture in wanted.split(",")


# G空間情報センターは続けて取ると 403 を返すことがある（数十件取ったところで出る）。
# 1 件ごとに間を空け、403 は待ってから取り直す
PAUSE = 2
FORBIDDEN_WAITS = (30, 60, 120, 240)


def read_records() -> dict[str, dict]:
    if not SOURCE_FILES.exists():
        return {}
    return {r["file"]: r for r in map(json.loads, SOURCE_FILES.read_text().splitlines())}


def write_records(records: dict[str, dict]) -> None:
    lines = "".join(json.dumps(records[f], ensure_ascii=False) + "\n" for f in sorted(records))
    write_atomic(SOURCE_FILES, lines.encode())


def fetch_zip(url: str, records: dict[str, dict]) -> Path:
    """zip を取り、取得の記録を records に入れる。手元の zip が前回と変わっていなければ取り直さない。"""
    file = url.rsplit("/", 1)[1]
    path = RAW / file
    RAW.mkdir(parents=True, exist_ok=True)
    previous = {k: v for k, v in records[file].items() if k != "file"} if file in records else None
    for wait in (*FORBIDDEN_WAITS, None):
        time.sleep(PAUSE)
        try:
            record = fetch_file(url, path, previous=previous, user_agent=USER_AGENT, timeout=300)
            records[file] = {"file": file, **record}
            return path
        except HTTPError as e:
            if e.code != 403 or wait is None:
                raise
            logger.info(f"  {path.name}: 403。{wait} 秒待って取り直す")
            time.sleep(wait)
    return path


def inner_csvs(path: Path) -> list[tuple[str, bytes]]:
    """外側の zip の中の zip を開き、(内側の zip の名前, CSV の中身) を返す。"""
    with zipfile.ZipFile(path) as outer:
        names = sorted(n for n in outer.namelist() if n.endswith(".csv.zip"))
        result = []
        for name in names:
            with zipfile.ZipFile(io.BytesIO(outer.read(name))) as inner:
                (csv,) = inner.namelist()
                result.append((name, inner.read(csv)))
        return result


def monthly_to_parquet(path: Path, kind: str, out: Path) -> int:
    """都道府県の全年月の CSV を 1 つの Parquet にする。値は文字列のまま持ち、型は dbt で付ける。"""
    csvs = inner_csvs(path)
    if not csvs:
        raise RuntimeError(f"{path.name} に CSV が無い")
    with tempfile.TemporaryDirectory() as tmp:
        for i, (name, body) in enumerate(csvs):
            if not body.startswith(HEADERS[kind].encode()):
                raise RuntimeError(f"{path.name} の {name} の見出しが想定と違う")
            (Path(tmp) / f"{i:03}.csv").write_bytes(body)
        con = duckdb.connect()
        with replacing(out) as partial:
            con.execute(
                f"""
                COPY (SELECT * FROM read_csv('{tmp}/*.csv', header = true, all_varchar = true))
                TO '{partial}' (FORMAT parquet, COMPRESSION zstd)
                """
            )
        return con.execute(f"SELECT count(*) FROM '{out}'").fetchone()[0]


def extract_master(path: Path) -> None:
    """マスタの zip から UTF-8 の CSV を取り出す（Shift_JIS 版は同じ内容なので使わない）。"""
    OUT.mkdir(parents=True, exist_ok=True)
    for name, body in inner_csvs(path):
        if "_sjis_" in name:
            continue
        csv = Path(name).name.removesuffix(".zip").replace("_utf8", "")
        write_atomic(OUT / csv, body.decode("utf-8-sig"))


def download_people_flow() -> None:
    urls = resource_urls()
    records = read_records()
    for url in urls:
        file = url.rsplit("/", 1)[1]
        if file in MASTERS:
            extract_master(fetch_zip(url, records))
            logger.info(f"  {file}")
            continue
        for pattern, kind in MONTHLY.items():
            if (m := pattern.fullmatch(file)) and selected(m.group(1)):
                out = OUT / kind / f"{m.group(1)}.parquet"
                out.parent.mkdir(parents=True, exist_ok=True)
                rows = monthly_to_parquet(fetch_zip(url, records), kind, out)
                logger.info(f"  {file}: {rows:,} 行")
    # 今回の一覧に無い zip の記録は残さない
    write_records({f: r for f, r in records.items() if f in {u.rsplit("/", 1)[1] for u in urls}})
    for kind in MONTHLY.values():
        if not any((OUT / kind).glob("*.parquet")):
            raise RuntimeError(f"{kind} の配布物が見つからない")
