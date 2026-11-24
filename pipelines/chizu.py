"""法務省 登記所備付地図データを取り込む。

1. list: G空間情報センターから取り込む zip の一覧を取る
2. download / convert: zip を取って 1 筆 1 行の Parquet にし、zip は消す

全国の zip は約 100GB あるので、取ったそばから変換して消す。Parquet が既にある zip は
取らない（ファイル名に年が入るので、原典が更新されると新しい名前になる）。

出力: data/chizu/parcel/<zip の名前>.parquet、data/chizu/sources.ndjson、
data/chizu/source_file.ndjson（取り込んだ zip ごとの取得の記録。Parquet を作ったときの記録を残す）
"""

import json
import logging
from multiprocessing import Pool
from pathlib import Path

import pyarrow.parquet as pq

from pipelines.chizu_convert import SCHEMA, convert
from pipelines.chizu_download import fetch_zip, list_moj
from shared.fetch import write_atomic

logger = logging.getLogger("pipelines")

PARCEL_DIR = Path("data/chizu/parcel")
SOURCE_FILES = Path("data/chizu/source_file.ndjson")


def parquet_path(file: str) -> Path:
    return PARCEL_DIR / f"{Path(file).stem}.parquet"


def converted(file: str) -> bool:
    """今の列で書いた Parquet があるか。列を足したときは古い Parquet を作り直す。"""
    path = parquet_path(file)
    return path.exists() and pq.read_schema(path).equals(SCHEMA)


def read_records() -> dict[str, dict]:
    if not SOURCE_FILES.exists():
        return {}
    return {r["file"]: r for r in map(json.loads, SOURCE_FILES.read_text().splitlines())}


def write_records(records: dict[str, dict]) -> None:
    lines = "".join(json.dumps(records[f], ensure_ascii=False) + "\n" for f in sorted(records))
    write_atomic(SOURCE_FILES, lines.encode())


def fetch_and_convert(source: dict) -> tuple[dict, dict, int]:
    """zip を取って Parquet にし、zip を消す。プロセスごとに 1 本ずつ受け持つ。"""
    zip_path, record = fetch_zip(source)
    rows = convert(zip_path, parquet_path(source["file"]))
    zip_path.unlink()
    return source, record, rows


def convert_all(sources: list[dict]) -> None:
    """Parquet（今の列のもの）か取得の記録の無い zip を取って変換する。今回の一覧に無い Parquet と記録は消す。

    並列は zip 単位にする。1 本の中の XML を並列にすると、親が筆の行を受け取って
    表にするところで 1 コアに詰まる。zip はプロセスの数しか同時に置かない。
    """
    wanted = {parquet_path(s["file"]) for s in sources}
    for stale in set(PARCEL_DIR.glob("*.parquet")) - wanted:
        stale.unlink()
    files = {s["file"] for s in sources}
    records = {f: r for f, r in read_records().items() if f in files}
    todo = [s for s in sources if not converted(s["file"]) or s["file"] not in records]
    logger.info("  変換するのは %d 本", len(todo))
    with Pool() as pool:
        for done, (source, record, rows) in enumerate(pool.imap_unordered(fetch_and_convert, todo), 1):
            records[source["file"]] = record
            # 途中で止まっても、変換済みの zip を次の実行で取り直さない
            write_records(records)
            logger.info("  [%d/%d] %s %s: %d 筆", done, len(todo), source["file"], source["title"], rows)
    write_records(records)


def download_chizu() -> None:
    convert_all(list_moj())
