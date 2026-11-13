# G空間情報センター

[G空間情報センター](https://www.geospatial.jp/)で公開されているデータを、SQL で集計・地図表示できるテーブルにしたデータセットです。Queria の `geospatial` として公開します。

## 出典と利用条件

| 原典 | スキーマ |
| --- | --- |
| [Project LINKS](https://www.mlit.go.jp/links/)（国土交通省 総合政策局 情報政策課）がG空間情報センターの[組織 sosei-joho](https://www.geospatial.jp/ckan/organization/sosei-joho)で公開しているオープンデータ（2024・2025 年度） | `links` |

- [Project LINKS の利用規約](https://www.mlit.go.jp/links/terms-of-use.html)により、[公共データ利用規約（第1.0版）（PDL1.0）](https://www.digital.go.jp/resources/open_data/public_data_license_v1.0)に従います
- 使うときは、たとえば「「倉庫業データ」（国土交通省 Project LINKS）（https://www.geospatial.jp/ckan/dataset/links-soukogyou-2025）を加工して作成」のように、出典と加工したことを書いてください
- 提供情報の正確性等は保証されていません

加工の内容:

- 配布ファイルの英語の列名を小文字のスネークケースにし、型を付けています。値の `None` は NULL にしています
- 列の title・description は、同じデータセットのデータ仕様書（XLSX の項目リスト）の項目名・単位・秘匿化処理・備考から付けています。仕様書のコードリストにある値の意味（20 個まで）も列の description に書いています
- 都道府県名で始まる住所・所在地の列があるテーブルには、2 桁の都道府県コード（`prefecture_code` など）を付けています。都道府県名で始まらない行（「伊東市」など）は NULL です
- 緯度・経度の列があるテーブルには点の `geometry` を付けています。日本の範囲から外れる値は NULL です。WKT の点の列（`*_geometry`）は geometry 型にしています
- 値そのものは変更していません

## テーブル（links スキーマ）

| テーブル | 内容 | 範囲 |
| --- | --- | --- |
| `tourism_accommodation_guests` | 宿泊旅行統計調査の延べ宿泊者数（従業者規模別・観光目的の割合別・国内外） | 都道府県 × 年 |
| `tourism_spending_overnight` / `tourism_spending_day_trip` | 旅行・観光消費動向調査の宿泊旅行・日帰り旅行の消費額 | 都道府県 × 年 |
| `drone_accidents` | 無人航空機の事故等報告 | 2022 年 12 月〜2025 年 3 月 |
| `drone_airspace_airport_vicinity` / `_yellow_zone` / `_red_zone` | 空港等の周辺空域、小型無人機等飛行禁止法のイエローゾーン・レッドゾーンのポリゴン | 全国 |
| `bus_route_transport_results` / `bus_charter_transport_results` / `taxi_transport_results` / `passenger_motor_carrier_overview` | 路線バス・貸切バス・タクシーの輸送実績報告と事業概況報告 | 全国 |
| `rideshare_transport_results` / `rideshare_registry` | 自家用有償旅客運送の輸送実績報告書と登録簿 | 東京・徳島・長崎運輸支局 |
| `rental_car_results` / `rental_car_office_vehicles` | レンタカーの貸渡実績報告書と事務所別の配置車両数 | 全国 |
| `trucking_business_results` | 貨物自動車運送事業の事業実績報告書 | 全国、2015〜2022 年度 |
| `trucking_business_results_financials` | 貨物自動車運送事業の事業実績と財務情報 | 全国のサンプル |
| `trucking_business_results_nara` / `trucking_financials_nara` | 貨物自動車運送事業の事業実績報告書と財務情報 | 奈良運輸支局管内、2023 年度 |
| `motor_carrier_accidents` | 自動車運送事業の事故報告書と交通事故統計の統合データ | 全国 |
| `motor_carrier_accident_reports` | 自動車運送事業の事故報告書 | 全国 |
| `railway_*` | 鉄道統計年報の運輸成績・営業キロ・営業損益・損益計算書・貸借対照表 | 事業者 × 年度 |
| `coastal_shipping_business_report` / `_2024` | 内航海運業の事業概況報告（2025・2024 年度の公開分で列が違う） | 全国 |
| `coastal_shipping_operator_productivity` | 内航船舶輸送統計調査による事業者別の生産性スコア | 全国 |
| `port_survey` | 港湾調査の入港船舶・海上貨物の集計 | 港 × 年 |
| `seafarer_business_status` | 船員法第111条に基づく事業状況報告 | 関東運輸局管内 |
| `seafarer_labor_survey_owned_ships` / `_other_ships` | 船員労働統計調査の第一号・第二号調査 | 全国 × 年 |
| `passenger_ferry_ships` / `ship_accidents` / `marine_forecast_areas` | 一般旅客定期航路事業の許可申請書（船舶）、船舶事故等調査報告書、地方海上予報区のポリゴン | 全国 |
| `coastal_shipping_port_pairs` / `truck_freight_prefecture_pairs` | 内航船舶輸送統計調査（積地・揚地の港の組）と自動車輸送統計調査（発地・着地の都道府県の組） | 全国のサンプル |
| `warehouse_registrations` | 倉庫業登録申請書と倉庫明細書 | 中部運輸局管内 |
| `warehouse_quarterly_usage` / `_2024` | 期末倉庫使用状況報告書（2025 年度公開は全国・2019〜2024 年度） | 事業所 × 四半期 |
| `warehouse_business_status` | 倉庫事業経営状況報告書 | 全国 |
| `vacant_house_bank_listings` / `vacant_house_bank_contracts` | 全国版空き家・空き地バンクの登録物件と成約物件 | 全国のサンプル |
| `code_lists` | データ仕様書のコードリスト（コードの値と意味、選択肢）。`package` と `column_name` で各テーブルの列と突き合わせる | 9 データセット |

## 使い方

都道府県別の延べ宿泊者数を新しい年から並べる:

```sql
SELECT prefecture_code, year, total_guest_count, stay_guest_count_foreign
FROM geospatial.links.tourism_accommodation_guests
ORDER BY year DESC, total_guest_count DESC
LIMIT 20;
```

## データの注意

- 事業者・営業所・船舶などの ID は、元の番号を隠すために新しく付けた番号です。同じデータセットの中のファイル同士は結合できますが、ほかのデータや別の年度の公開分の ID とは結合できません
- `*_rank` の列は、元の値を 10 段階に分けた区間（「9.0以上～12.0未満」など）の文字列です。区間の境界はファイルごとに違います
- 住所・所在地は都道府県・市区町村の単位に丸められています
- 自動車運送事業の事故の統合データと無人航空機の事故等報告は、2025 年度の公開分が 2024 年度の公開分を含むため、2025 年度の公開分だけを取り込んでいます
- 期末倉庫使用状況報告書は、2024 年度の公開分（`warehouse_quarterly_usage_2024`）と 2025 年度の公開分（`warehouse_quarterly_usage`）で期間と地域が一部重なります。両方を足すと重なる期間を二重に数えます
- 無人航空機の飛行計画（月ごとの GeoJSON、合計約 16 GB）は取り込んでいません

## 開発

```bash
uv sync
uv run python -c "import main; main.download()"   # data/links/ に取得
uv run python tools/generate_models.py             # models/links/ を作り直す（仕様書や列が変わったとき）
uv run dbt build --profiles-dir ci                 # 公開せずに手元で作る
scripts/build.sh                                   # Queria に公開する
```

`models/links/` の SQL と `*.table.yml` は `tools/generate_models.py` が作ります。手で直さず、`pipelines/links_tables.py`（テーブルとファイルの対応）か `tools/generate_models.py`（都道府県コードと geometry を付ける列）を直して作り直してください。
