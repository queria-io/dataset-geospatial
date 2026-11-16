# ビルドと更新

データセットの概要は [README.md](README.md) にあります。ここにはこのリポジトリでデータセットをビルド・更新する手順を書きます。

## 開発

```bash
uv sync
uv run python -c "import main; main.download()"   # data/links/ に取得（SYNC_MODE で選んだスキーマ。既定は links）
uv run python tools/generate_models.py             # models/links/ を作り直す（仕様書や列が変わったとき）
uv run dbt build --profiles-dir ci --select links  # 公開せずに手元で作る
scripts/build.sh                                   # Queria に公開する
```

`main.py` は環境変数 `SYNC_MODE`（スキーマ名のカンマ区切り）で選んだスキーマだけを取得して `dbt build --select` します。空なら `links` だけです。選ばなかったスキーマのテーブルは、公開中のバージョンのまま残ります。

```bash
SYNC_MODE=people_flow scripts/build.sh   # 人流（配布物は約 190MB）
SYNC_MODE=chizu scripts/build.sh         # 登記所備付地図（zip は全国で約 100GB）
SYNC_MODE=chizu CHIZU_PREFECTURES=13,14 uv run python -c "import main; main.download()"  # 東京都と神奈川県だけ取得
```

- main への push と手動の実行（workflow_dispatch）の Sync は `links` だけを作ります
- `people_flow` の原典は 2021 年 12 月分で公開を終えているので、作り直すのは定義を変えたときだけです。取得した zip は `data/people_flow/raw/` に置いて使い回します
- `chizu` の原典は年 1 回（春）更新されます。全国の zip は約 100GB あり、GitHub のランナーでは作れないので、手元で作ります

`models/links/` の SQL とテーブルの Markdown は `tools/generate_models.py` が作ります。手で直さず、`pipelines/links_tables.py`（テーブルとファイルの対応）か `tools/generate_models.py`（都道府県コードと geometry を付ける列）を直して作り直してください。
