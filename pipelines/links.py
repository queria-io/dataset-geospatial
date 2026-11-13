"""Project LINKS の公開データを G空間情報センターの CKAN API から取得する。

データセット（package）ごとに package_show でファイルの一覧を引き、pipelines/links_tables.py に
載せたファイルとデータ仕様書（99_ で始まる XLSX）を data/links/<package>/ に置く。
データ仕様書の項目リストは、列の説明を作るために data/links/<package>/spec.json にする。

一部のファイルは、CKAN に登録された URL のファイル名の先頭に www.geospatial.jp が付いていて、
その URL では 500 が返る。download/ の直後の www.geospatial.jp を除いた URL で取得する。
"""

import csv
import json
import logging
import re
import unicodedata
from pathlib import Path

import openpyxl

from pipelines.links_tables import PACKAGES, TABLES
from shared.fetch import download, fetch, replacing, write_atomic

logger = logging.getLogger("pipelines")

USER_AGENT = "dataset-geospatial (+https://github.com/queria-io/dataset-geospatial)"
API = "https://www.geospatial.jp/ckan/api/3/action/package_show?id="
DATA = Path("data/links")


def resource_url(url: str) -> str:
    return url.replace("/download/www.geospatial.jp", "/download/")


def file_name(url: str) -> str:
    return resource_url(url).rsplit("/", 1)[-1]


def wanted(package: str, name: str) -> bool:
    if name.startswith("99_") and name.endswith(".xlsx"):
        return True
    return any(s.package == package and name.startswith(s.prefix) for s in TABLES)


def clean(value) -> str | None:
    if value in (None, ""):
        return None
    text = unicodedata.normalize("NFKC", str(value)).replace("​", "")
    return re.sub(r"\s+", " ", text).strip() or None


# 項目リストの見出しは仕様書によって「フィールド名・項目」と「英語カラム・日本語カラム」の 2 通りある
HEADERS = {
    "フィールド名": "name",
    "英語カラム": "name",
    "項目": "title",
    "日本語カラム": "title",
    "データ型": "type",
    "単位": "unit",
    "秘匿化処理の有無": "masking",
    "備考": "note",
    "出典": "source",
}


def parse_files(sheet) -> dict[str, dict]:
    """「01_データ構成（メタデータ）」の配信情報から、ファイル名ごとの説明と出典を引く。"""
    files, current = {}, None
    for row in sheet.iter_rows(values_only=True):
        cells = [clean(c) for c in row if clean(c)]
        if len(cells) < 2:
            continue
        label, value = cells[-2], cells[-1]
        if label == "タイトル(ファイル名)":
            current = files.setdefault(value, {})
        elif current is not None and label in ("説明", "出典") and label not in current:
            current["description" if label == "説明" else "source"] = value
    return files


def parse_codes(sheet) -> list[dict]:
    """「03_コードリスト」のシートを、列名・項目名・コード・内容の行にする。

    見出しは「フィールド名・項目名・コード・内容」か「フィールド名・項目名・内容（選択肢）」。
    コードの無い選択肢の一覧は code を None にする。
    """
    rows = [[clean(c) for c in row] for row in sheet.iter_rows(values_only=True)]
    header_at = next((i for i, row in enumerate(rows) if "フィールド名" in row), None)
    if header_at is None:
        return []
    start = rows[header_at].index("フィールド名")
    codes = []
    for row in rows[header_at + 1 :]:
        cells = row[start:]
        if len(cells) < 3 or not cells[0]:
            continue
        values = [c for c in cells[2:] if c]
        if not values:
            continue
        code, label = (values[0], values[1]) if len(values) > 1 else (None, values[0])
        codes.append({"name": cells[0], "title": cells[1], "code": code, "label": label})
    return codes


def parse_spec(path: Path) -> dict:
    """データ仕様書を、ファイルの説明（files）、コードリスト（codes）と、ファイル番号 NN_ ごとの列の一覧にする。

    列の一覧は「02_項目リスト_NN_…」のシートから作る。
    """
    workbook = openpyxl.load_workbook(path, read_only=True, data_only=True)
    sheets = {"files": parse_files(workbook.worksheets[0]), "codes": []}
    for sheet in workbook.worksheets:
        if "コードリスト" in sheet.title:
            sheets["codes"] += parse_codes(sheet)
            continue
        number = re.search(r"項目リスト_(\d+)", sheet.title)
        if not number:
            continue
        rows = [[clean(c) for c in row] for row in sheet.iter_rows(values_only=True)]
        header_at = next(i for i, row in enumerate(rows) if {"フィールド名", "英語カラム"} & set(row))
        columns = {HEADERS[h]: i for i, h in enumerate(rows[header_at]) if h in HEADERS}
        fields = [
            {key: row[i] if i < len(row) else None for key, i in columns.items()}
            for row in rows[header_at + 1 :]
        ]
        sheets[number.group(1).zfill(2) + "_"] = [f for f in fields if f.get("name")]
    return sheets


def write_code_lists():
    """各データセットのコードリストを data/links/code_lists.csv にまとめる。"""
    with replacing(DATA / "code_lists.csv") as partial, partial.open("w", newline="") as handle:
        writer = csv.writer(handle)
        writer.writerow(["package", "field_name", "item_name", "code", "label"])
        for package in PACKAGES:
            spec = json.loads((DATA / package / "spec.json").read_text())
            for c in spec["codes"]:
                writer.writerow([package, c["name"], c["title"], c["code"], c["label"]])


def download_links():
    for package in PACKAGES:
        meta = json.loads(fetch(API + package, user_agent=USER_AGENT))["result"]
        folder = DATA / package
        folder.mkdir(parents=True, exist_ok=True)
        for resource in meta["resources"]:
            name = file_name(resource["url"])
            if not wanted(package, name):
                continue
            path = folder / name
            logger.info("  %s/%s", package, name)
            download(resource_url(resource["url"]), path, user_agent=USER_AGENT)
            if name.startswith("99_"):
                write_atomic(folder / "spec.json", json.dumps(parse_spec(path), ensure_ascii=False, indent=1))
    write_code_lists()
