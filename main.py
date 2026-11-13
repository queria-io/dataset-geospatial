"""G空間情報センターのデータパイプライン。

スキーマごとに取得して dbt build する。作るスキーマは SYNC_MODE（カンマ区切り）で選び、
空なら links だけを作る。選ばなかったスキーマのテーブルは、公開中のバージョンのまま残る
（shared/scripts/build-fdl.sh は公開中のカタログを checkout してから作る）。

- links: Project LINKS の公開データ（CSV・GeoJSON・データ仕様書）
- people_flow: 全国の人流オープンデータ（配布物は約 190MB、2021 年 12 月分で公開を終えている）
- chizu: 登記所備付地図データ（zip は全国で約 100GB。GitHub のランナーでは作れないので、手元で作る）

例: SYNC_MODE=chizu scripts/build.sh
"""

import logging
import os

from dbt.cli.main import dbtRunner

from pipelines.chizu import download_chizu
from pipelines.links import download_links
from pipelines.people_flow import download_people_flow

# dbt を読み込むとルートロガーが先に設定されるので、force で上書きする
logging.basicConfig(level=logging.INFO, format="%(message)s", force=True)
logger = logging.getLogger("pipelines")

DOWNLOADS = {
    "links": download_links,
    "people_flow": download_people_flow,
    "chizu": download_chizu,
}


def schemas() -> list[str]:
    names = [s.strip() for s in os.environ.get("SYNC_MODE", "").split(",") if s.strip()] or ["links"]
    unknown = sorted(set(names) - DOWNLOADS.keys())
    if unknown:
        raise SystemExit(f"SYNC_MODE に知らないスキーマがある: {', '.join(unknown)}")
    return names


def download(names: list[str] | None = None):
    for name in names or schemas():
        logger.info("download: %s", name)
        DOWNLOADS[name]()


def dbt_build(names: list[str] | None = None):
    dbt = dbtRunner()
    select = ["--select", *(names or schemas())]
    for command in (["deps"], ["build", *select], ["docs", "generate"]):
        if not dbt.invoke(command).success:
            raise SystemExit(f"dbt {' '.join(command)} failed")


def main():
    names = schemas()
    download(names)
    logger.info("dbt build: %s", ", ".join(names))
    dbt_build(names)


if __name__ == "__main__":
    main()
