"""法務省 登記所備付地図データを取り込む。

1. list: G空間情報センターから取り込む zip の一覧を取る
2. download / convert: zip を取って 1 筆 1 行の Parquet にし、zip は消す

全国の zip は約 100GB あるので、取ったそばから変換して消す。Parquet が既にある zip は
取らない（ファイル名に年が入るので、原典が更新されると新しい名前になる）。

出力: data/chizu/parcel/<zip の名前>.parquet と data/chizu/sources.ndjson
"""

import logging
from multiprocessing import Pool
from pathlib import Path

from pipelines.chizu_convert import convert
from pipelines.chizu_download import fetch_zip, list_moj

logger = logging.getLogger("pipelines")

PARCEL_DIR = Path("data/chizu/parcel")


def parquet_path(file: str) -> Path:
    return PARCEL_DIR / f"{Path(file).stem}.parquet"


def fetch_and_convert(source: dict) -> tuple[dict, int]:
    """zip を取って Parquet にし、zip を消す。プロセスごとに 1 本ずつ受け持つ。"""
    zip_path = fetch_zip(source)
    rows = convert(zip_path, parquet_path(source["file"]))
    zip_path.unlink()
    return source, rows


def convert_all(sources: list[dict]) -> None:
    """Parquet の無い zip を取って変換する。今回の一覧に無い Parquet は消す。

    並列は zip 単位にする。1 本の中の XML を並列にすると、親が筆の行を受け取って
    表にするところで 1 コアに詰まる。zip はプロセスの数しか同時に置かない。
    """
    wanted = {parquet_path(s["file"]) for s in sources}
    for stale in set(PARCEL_DIR.glob("*.parquet")) - wanted:
        stale.unlink()
    todo = [s for s in sources if not parquet_path(s["file"]).exists()]
    logger.info("  変換するのは %d 本", len(todo))
    with Pool() as pool:
        for done, (source, rows) in enumerate(pool.imap_unordered(fetch_and_convert, todo), 1):
            logger.info("  [%d/%d] %s %s: %d 筆", done, len(todo), source["file"], source["title"], rows)


def download_chizu() -> None:
    convert_all(list_moj())
