"""data/links/ に取得したファイルとデータ仕様書から、models/links/ のモデルと *.table.yml を作る。

    uv run python -c "import main; main.download()"
    uv run python tools/generate_models.py

列名は配布ファイルの英語の列名を小文字のスネークケースにしたもの。列の title・description は
データ仕様書の項目リスト（項目・単位・秘匿化処理の有無・備考）から作る。
仕様書の更新やファイルの列が変わったときに流し直し、差分を確認してからコミットする。
"""

import json
import re
import sys
import unicodedata
from pathlib import Path

import duckdb
import yaml

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from pipelines.links_tables import TABLES  # noqa: E402

DATA = Path("data/links")
MODELS = Path("models/links")

# 都道府県コードを付ける列。(元の列, 付ける列)
PREFECTURE = {
    "vacant_house_bank_listings": [("PREFECTURE", "prefecture_code")],
    "vacant_house_bank_contracts": [("PREFECTURE", "prefecture_code")],
    "taxi_transport_results": [("Address", "prefecture_code")],
    "passenger_motor_carrier_overview": [("Address", "prefecture_code")],
    "motor_carrier_accidents": [("ACCIDENT_LOCATION", "prefecture_code")],
    "drone_accidents": [("OCCURRENCE_LOCATION", "prefecture_code")],
    "coastal_shipping_business_report": [("Address", "prefecture_code")],
    "coastal_shipping_business_report_2024": [("Address", "prefecture_code")],
    "rental_car_results": [("PREFECTURE_NAME", "prefecture_code")],
    "rental_car_office_vehicles": [("OFFICE_VEHICLE_ALLOCATION_LIST_LOCATION", "prefecture_code")],
    "rideshare_transport_results": [("ADDRESS", "prefecture_code")],
    "rideshare_registry": [("ADDRESS", "prefecture_code")],
    "warehouse_quarterly_usage": [("OFFICE_ADDRESS", "prefecture_code")],
    "warehouse_quarterly_usage_2024": [("OFFICE_ADDRESS", "prefecture_code")],
    "port_survey": [("PREFECTURE_NAME", "prefecture_code")],
    "passenger_ferry_ships": [("location", "prefecture_code")],
    "ship_accidents": [("Location_of_Occurrence", "prefecture_code")],
    "coastal_shipping_port_pairs": [
        ("LOADING PORT_PREFECTURE NAME", "loading_prefecture_code"),
        ("UNLOADING PORT_PREFECTURE NAME", "unloading_prefecture_code"),
    ],
    "truck_freight_prefecture_pairs": [
        ("都道府県名_発地", "origin_prefecture_code"),
        ("都道府県名_着地", "destination_prefecture_code"),
    ],
}

# 都道府県コードの数値を 2 桁の文字列にする列
PREFECTURE_NUMBER = {"PREFECTURE_CODE"}

# 地点の geometry を作る緯度・経度の列。(経度, 緯度)
POINT = {
    "motor_carrier_accidents": ("LONGITUDE", "LATITUDE"),
    "motor_carrier_accident_reports": ("LONGITUDE", "LATITUDE"),
    "ship_accidents": ("Accident_Longitude", "Accident_Latitude"),
    "warehouse_registrations": ("LONGITUDE", "LATITUDE"),
    "rental_car_results": ("ADDRESS_LONGITUDE", "ADDRESS_LATITUDE"),
    "rideshare_transport_results": ("LONGITUDE", "LATITUDE"),
}

PREFECTURE_FIELD = {
    "title": "都道府県コード",
    "annotations": {"queria": {"semantic": {"role": "entity", "name": "prefecture"}}},
}


def block_string(dumper, value):
    style = "|" if "\n" in value else None
    return dumper.represent_scalar("tag:yaml.org,2002:str", value, style=style)


yaml.SafeDumper.add_representer(str, block_string)


def snake(name: str) -> str:
    text = unicodedata.normalize("NFKC", name).lstrip("\ufeff").lower()
    text = re.sub(r"^(\d+)(st|nd|rd|th)_floor", r"floor\1", text)
    return re.sub(r"_+", "_", re.sub(r"[^a-z0-9]+", "_", text)).strip("_")


def key(name: str | None) -> str:
    """仕様書と配布ファイルの列名を突き合わせる鍵。空白と、末尾の単位の括弧（「(kg)」など）を除く。"""
    text = re.sub(r"\s+", "", unicodedata.normalize("NFKC", name or "")).lstrip("\ufeff")
    return re.sub(r"\((kg|t|km|円|千円|%)\)$", "", text, flags=re.I)


def source_file(package: str, prefix: str) -> Path:
    files = sorted(
        p for p in (DATA / package).glob(prefix + "*") if p.suffix in (".csv", ".geojson")
    )
    if len(files) != 1:
        raise SystemExit(f"{package}/{prefix}: {files}")
    return files[0]


def spec_fields(package: str, prefix: str) -> dict[str, dict]:
    spec = json.loads((DATA / package / "spec.json").read_text())
    fields = {}
    for field in spec.get(prefix, []):
        fields.setdefault(key(field["name"]), field)
        fields.setdefault(key(field.get("title")), field)
    return fields


def describe(field: dict | None) -> dict:
    if not field:
        return {}
    out = {}
    if field.get("title"):
        out["title"] = field["title"]
    parts = []
    if field.get("unit") and field["unit"] not in ("-", "ー", "―"):
        parts.append(f"単位: {field['unit']}")
    if field.get("masking") and not field["masking"].startswith("秘匿化無"):
        parts.append(f"秘匿化: {field['masking']}")
    if field.get("note") and field["note"] not in ("-", "新規作成"):
        parts.append(field["note"])
    if parts:
        out["description"] = "。".join(p.rstrip("。") for p in parts)
    return out


def table_description(source, path: Path) -> str:
    files = json.loads((DATA / source.package / "spec.json").read_text())["files"]
    match = files.get(path.name) or next(
        (v for k, v in files.items() if k.startswith(source.prefix) and len([x for x in files if x.startswith(source.prefix)]) == 1),
        {},
    )
    lines = [match.get("description") or source.title]
    if match.get("source"):
        lines.append(f"元の資料: {match['source']}")
    lines.append(f"G空間情報センターのデータセット {source.package} の {path.name} を、列名を小文字にして型を付けたテーブルです。列の説明は同じデータセットのデータ仕様書から付けています。")
    return "\n\n".join(lines)


def quote(name: str) -> str:
    return '"' + name.replace('"', '""') + '"'


def csv_columns(con, path: Path) -> list[tuple[str, str]]:
    rows = con.sql(f"describe select * from {read_csv(path)}").fetchall()
    return [(r[0], r[1]) for r in rows]


# 見出しのセルに改行を含み、strict_mode のままでは読めないファイル
LENIENT = {"02_naikoukaiungyou_naikousenpakuyusoutoukei.csv"}


def read_csv(path: Path) -> str:
    strict = ", strict_mode = false" if path.name in LENIENT else ""
    return (
        f"read_csv('{path.as_posix()}', header = true, delim = ',', quote = '\"', escape = '\"', "
        f"nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1{strict})"
    )


def code_values(package: str) -> dict[str, list[dict]]:
    """データ仕様書のコードリストを、列名の鍵ごとの値の一覧にする。"""
    codes = {}
    for code in json.loads((DATA / package / "spec.json").read_text()).get("codes", []):
        if code["code"] == "-":
            continue
        codes.setdefault(key(code["name"]), []).append(code)
    return codes


def with_codes(field: dict, codes: list[dict] | None) -> dict:
    """コードリストに値の意味がある列は、説明に「値: 1960 = 1960~1979年、…」を足す。"""
    if not codes:
        return field
    if len(codes) > 20:
        text = "値の一覧は code_lists テーブル"
    elif all(c["code"] is None for c in codes):
        text = "選択肢: " + "、".join(c["label"] for c in codes)
    else:
        text = "値: " + "、".join(f"{c['code']} = {c['label']}" for c in codes)
    description = "。".join(x for x in (field.get("description"), text) if x)
    return {**field, "description": description}


def csv_model(con, source, path: Path) -> tuple[str, list[dict]]:
    spec = spec_fields(source.package, source.prefix)
    codes = code_values(source.package)
    selects, fields = [], []
    for column, column_type in csv_columns(con, path):
        name = snake(spec.get(key(column), {}).get("name", column) if not column.isascii() else column)
        if not name:
            raise SystemExit(f"{path}: 列 {column} の英語名が仕様書に無い")
        field = {"name": name, **with_codes(describe(spec.get(key(column))), codes.get(key(column)))}
        expression = quote(column)
        if column in PREFECTURE_NUMBER:
            expression = f"lpad(cast({expression} as varchar), 2, '0')"
            field = {"name": "prefecture_code", **PREFECTURE_FIELD, **describe(spec.get(key(column)))}
            name = "prefecture_code"
        elif column.lower().endswith("_geometry") and column_type == "VARCHAR":
            expression = f"st_geomfromtext({expression})"
            field.setdefault("description", "市区町村などの代表点（WKT の POINT を geometry にしたもの）")
        selects.append(f"    {expression} as {name}")
        fields.append(field)
    for column, name in PREFECTURE.get(source.table, []):
        selects.append(f"    {{{{ prefecture_code('{quote(column)}') }}}} as {name}")
        origin = snake(column if column.isascii() else spec.get(key(column), {}).get("name", column))
        fields.append(
            {
                "name": name,
                **PREFECTURE_FIELD,
                "description": f"{origin} の先頭の都道府県名から付けたコード。都道府県名で始まらない行は NULL",
            }
        )
    if source.table in POINT:
        lon, lat = (f"try_cast({quote(c)} as double)" for c in POINT[source.table])
        selects.append(
            f"    case when {lat} between 20 and 46 and {lon} between 122 and 154\n"
            f"        then st_point({lon}, {lat}) end as geometry"
        )
        fields.append(
            {
                "name": "geometry",
                "title": "地点",
                "description": "緯度・経度の列から作った点。日本の範囲（北緯 20〜46 度・東経 122〜154 度）から外れる値は NULL",
            }
        )
    sql = (
        f"{{# {source.title}（G空間情報センター {source.package} の {path.name}） #}}\n\n"
        "select\n" + ",\n".join(selects) + f"\nfrom {read_csv(path)}\n"
    )
    return sql, fields


def geojson_model(con, source, path: Path) -> tuple[str, list[dict]]:
    spec = spec_fields(source.package, source.prefix)
    columns = [r[0] for r in con.sql(f"describe select * from st_read('{path.as_posix()}')").fetchall()]
    selects, fields = [], []
    for column in (c for c in columns if c != "OGC_FID"):
        name = "geometry" if column == "geom" else snake(column)
        selects.append(f"    {quote(column)} as {name}")
        fields.append({"name": name, **describe(spec.get(key(column)))})
    sql = (
        f"{{# {source.title}（G空間情報センター {source.package} の {path.name}） #}}\n\n"
        "select\n" + ",\n".join(selects) + f"\nfrom st_read('{path.as_posix()}')\n"
    )
    return sql, fields


def main():
    con = duckdb.connect()
    con.install_extension("spatial")
    con.load_extension("spatial")
    MODELS.mkdir(parents=True, exist_ok=True)
    for source in TABLES:
        path = source_file(source.package, source.prefix)
        model = geojson_model if path.suffix == ".geojson" else csv_model
        sql, fields = model(con, source, path)
        (MODELS / f"{source.table}.sql").write_text(sql)
        table = {
            "schema": "links",
            "name": source.table,
            "title": source.title,
            "description": table_description(source, path),
            "sources": [{"path": f"https://www.geospatial.jp/ckan/dataset/{source.package}"}],
            "fields": fields,
        }
        (MODELS / f"{source.table}.table.yml").write_text(
            yaml.safe_dump(table, allow_unicode=True, sort_keys=False, width=1000)
        )
        print(source.table, len(fields))
    write_code_lists()


CODE_LISTS_SQL = """{# データ仕様書のコードリスト（pipelines/links.py が data/links/code_lists.csv にまとめる） #}

select
    package,
    field_name,
    {{ snake_case('field_name') }} as column_name,
    item_name,
    code,
    label
from read_csv('data/links/code_lists.csv', header = true, all_varchar = true)
"""


def write_code_lists():
    (MODELS / "code_lists.sql").write_text(CODE_LISTS_SQL)
    table = {
        "schema": "links",
        "name": "code_lists",
        "title": "データ仕様書のコードリスト",
        "description": (
            "各データセットのデータ仕様書の「コードリスト」のシートです。1 行が 1 つの列の 1 つの値です。"
            "コードの値（code）と意味（label）、コードの無い列は選択肢（label）を持ちます。"
            "ほかのテーブルとは package と column_name で突き合わせます。"
            "値の数が 20 以下の列は、各テーブルの列の説明にも同じ内容を書いています。"
        ),
        "sources": [{"path": "https://www.geospatial.jp/ckan/organization/sosei-joho"}],
        "fields": [
            {"name": "package", "title": "データセット", "description": "G空間情報センターのデータセットの名前（links-soukogyou-2025 など）"},
            {"name": "field_name", "title": "フィールド名", "description": "データ仕様書の表記のまま"},
            {"name": "column_name", "title": "列名", "description": "このデータセットのテーブルでの列名（field_name を小文字のスネークケースにしたもの）"},
            {"name": "item_name", "title": "項目名"},
            {"name": "code", "title": "コード", "description": "コードの無い選択肢の一覧では NULL"},
            {"name": "label", "title": "内容"},
        ],
    }
    (MODELS / "code_lists.table.yml").write_text(
        yaml.safe_dump(table, allow_unicode=True, sort_keys=False, width=1000)
    )


if __name__ == "__main__":
    main()
