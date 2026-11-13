"""G空間情報センターのデータパイプライン。

1. links: Project LINKS の公開データ（CSV・GeoJSON・データ仕様書）を取得する
2. dbt: dbt ビルド
"""

import logging

from dbt.cli.main import dbtRunner

from pipelines.links import download_links

# dbt を読み込むとルートロガーが先に設定されるので、force で上書きする
logging.basicConfig(level=logging.INFO, format="%(message)s", force=True)
logger = logging.getLogger("pipelines")


def download():
    logger.info("1/2: links (Project LINKS)")
    download_links()


def dbt_build():
    dbt = dbtRunner()
    for command in (["deps"], ["build"], ["docs", "generate"]):
        if not dbt.invoke(command).success:
            raise SystemExit(f"dbt {' '.join(command)} failed")


def main():
    download()
    logger.info("2/2: dbt build")
    dbt_build()


if __name__ == "__main__":
    main()
