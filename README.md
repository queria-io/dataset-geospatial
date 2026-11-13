# G空間情報センター

[G空間情報センター](https://www.geospatial.jp/)で公開されているデータを、SQL で集計・地図表示できるテーブルにしたデータセットです。Queria の `geospatial` として公開します。

## 出典と利用条件

| 原典 | スキーマ |
| --- | --- |
| [Project LINKS](https://www.mlit.go.jp/links/)（国土交通省 総合政策局 情報政策課）がG空間情報センターの[組織 sosei-joho](https://www.geospatial.jp/ckan/organization/sosei-joho)で公開しているオープンデータ（2024・2025 年度） | `links` |
| [全国の人流オープンデータ（1kmメッシュ、市区町村単位発地別）](https://www.geospatial.jp/ckan/dataset/mlit-1km-fromto)（国土交通省） | `people_flow` |
| 登記所備付地図データ（法務省、[法務省の案内](https://www.moj.go.jp/MINJI/minji05_00494.html)） | `chizu` |

利用条件はスキーマごとに違います。

### links

- [Project LINKS の利用規約](https://www.mlit.go.jp/links/terms-of-use.html)により、[公共データ利用規約（第1.0版）（PDL1.0）](https://www.digital.go.jp/resources/open_data/public_data_license_v1.0)に従います
- 使うときは、たとえば「「倉庫業データ」（国土交通省 Project LINKS）（https://www.geospatial.jp/ckan/dataset/links-soukogyou-2025）を加工して作成」のように、出典と加工したことを書いてください
- 提供情報の正確性等は保証されていません

### people_flow

- [全国の人流オープンデータ利用規約](https://www.geospatial.jp/ckan/dataset/mlit-1km-fromto/resource/5a3705d7-b321-4f33-b0d9-0c4c379e96c3)（政府標準利用規約 2.0 準拠、CC BY 4.0 互換）に従います。商用利用もできます
- 使うときは「出典：『全国の人流オープンデータ』（国土交通省）（https://www.geospatial.jp/ckan/dataset/mlit-1km-fromto）を加工して作成」のように出典と加工したことを書いてください。Queria の値をさらに集計・加工したときも同じです

### chizu

- 登記所備付地図データ利用規約にしたがって、使うときは出典（「登記所備付地図データ○○市」（法務省）とデータセットのページ URL）と、加工したものであることを明記してください。市区町村ごとの名前と URL は `chizu.source` にあります
- 他の情報と照合して特定の個人を識別する使い方は、規約で禁止されています

### links の加工の内容


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

## links のデータの注意

- 事業者・営業所・船舶などの ID は、元の番号を隠すために新しく付けた番号です。同じデータセットの中のファイル同士は結合できますが、ほかのデータや別の年度の公開分の ID とは結合できません
- `*_rank` の列は、元の値を 10 段階に分けた区間（「9.0以上～12.0未満」など）の文字列です。区間の境界はファイルごとに違います
- 住所・所在地は都道府県・市区町村の単位に丸められています
- 自動車運送事業の事故の統合データと無人航空機の事故等報告は、2025 年度の公開分が 2024 年度の公開分を含むため、2025 年度の公開分だけを取り込んでいます
- 期末倉庫使用状況報告書は、2024 年度の公開分（`warehouse_quarterly_usage_2024`）と 2025 年度の公開分（`warehouse_quarterly_usage`）で期間と地域が一部重なります。両方を足すと重なる期間を二重に数えます
- 無人航空機の飛行計画（月ごとの GeoJSON、合計約 16 GB）は取り込んでいません

## テーブル（people_flow スキーマ）

| テーブル | 内容 |
| --- | --- |
| `people_flow.mesh_population` | 1 行が 1 メッシュ・1 か月・平休日・時間帯の滞在人口。3,808 万行 |
| `people_flow.city_population_by_origin` | 1 行が 1 市区町村・1 か月・平休日・時間帯・居住地区分の滞在人口。234 万行 |
| `people_flow.mesh` | 1 行が 1 つの 1km メッシュ。形・中心と、属する都道府県・市区町村。38 万行 |
| `people_flow.city` | 1 行が 1 市区町村。名前と地方区分 |

使い方:

駅の周りの休日の昼の人出を、2019〜2021 年の 4 月で比べる（駅は国土数値情報の `nlftp.railway.station`）:

```sql
WITH station_mesh AS (
    SELECT DISTINCT s.station_name, m.mesh_code
    FROM nlftp.railway.station AS s
    JOIN geospatial.people_flow.mesh AS m ON ST_Contains(m.geometry, s.geometry)
    WHERE s.station_name IN ('新宿', '渋谷') AND m.prefecture_code = '13'
)
SELECT station_name, date, sum(population) AS population
FROM geospatial.people_flow.mesh_population AS p
JOIN station_mesh USING (mesh_code)
WHERE p.day_type = '休日' AND p.time_of_day = '昼'
  AND p.date IN ('2019-04-01', '2020-04-01', '2021-04-01')
GROUP BY ALL
ORDER BY station_name, date;
```

駅の代表点は路線ごとにあるので、1 つの駅が複数のメッシュにかかることがあります。

平日の昼の滞在人口を、国勢調査の夜間人口（`e_stat.census.population_mesh_1km`）と比べる:

```sql
SELECT p.mesh_code, p.population AS weekday_daytime, c.value AS census_population,
       round(p.population / c.value, 1) AS ratio
FROM geospatial.people_flow.mesh_population AS p
JOIN e_stat.census.population_mesh_1km AS c ON c.mesh_code = p.mesh_code AND c.cat01 = '0010'
WHERE p.date = '2019-10-01' AND p.day_type = '平日' AND p.time_of_day = '昼'
  AND p.prefecture_code = '13' AND c.value >= 100
ORDER BY ratio DESC;
```

市区町村に県外から来た人の推移:

```sql
SELECT date, origin, population
FROM geospatial.people_flow.city_population_by_origin
WHERE lg_code = '472077'  -- 沖縄県石垣市
  AND day_type = '休日' AND time_of_day = '昼'
  AND origin IN ('同一地方', '他の地方')
ORDER BY date, origin;
```

`mesh_code` は e-Stat などのメッシュ統計と同じ 3 次メッシュコード（8 桁）、`city_code` は 5 桁の市区町村コード、`lg_code` は検査数字を付けた 6 桁の全国地方公共団体コードです。地図にするときは `mesh_population` の `lng`・`lat`（メッシュの中心）か、`mesh` の `geometry` を使います。

### 滞在人口の注意

- 株式会社 Agoop がスマートフォンのアプリから集めた位置情報を、日本の総人口に拡大推計し、滞在時間で按分した換算人口です。詳しい作り方は原典の[定義書](https://www.geospatial.jp/ckan/dataset/mlit-1km-fromto/resource/e2083495-8095-4119-a865-e5c22e6a7eee)にあります
- 値はその月の 1 日あたりの平均です。月をまたいで合計すると意味のない数になります。期間で比べるときは月ごとの値か、その平均を使います
- 時間帯は、昼が 11〜14 時台、深夜が 1〜4 時台、終日が 0〜23 時台の平均です。休日は土曜・日曜・祝日です
- 全日・終日の行は、平日と休日、昼と深夜の合計ではありません（それぞれの平均です）。`day_type` と `time_of_day` は 1 つずつに絞って使います
- 10 人未満の値は原典が出力していないため、行がありません。人の少ないメッシュ・市区町村・居住地区分は欠けます
- メッシュの合計は、滞在した人を場所ごとに数えたものです。終日の値を全国で合計すると、ほぼ日本の総人口になります（2020 年 1 月の全日・終日で 1 億 2,688 万人）
- 居住地区分の「同一都道府県」は同じ都道府県のほかの市区町村、「同一地方」は同じ地方のほかの都道府県、「他の地方」はそれ以外です。地方は `people_flow.city` の `region`（北海道・東北・関東・北陸・中部・近畿・中国・四国・九州・沖縄）です
- 政令指定都市は区の単位で、市の合計の行はありません

### コードの注意

- 福岡県那珂川市は、2019 年のデータでは旧那珂川町のコード（40305）です。2020 年から 40231 です。続けて見るときは両方のコードで絞ります
- `city_population_by_origin` の 2019 年には、北方領土の色丹村・泊村・蘂取村（01695・01696・01699）の行が少しあります。`people_flow.city` には入っていません
- `people_flow.mesh` の都道府県・市区町村は 2020 年版の 1km メッシュ属性によります。2019 年版とは、那珂川市など 70 メッシュの市区町村コードが違います。各年の値は `mesh_population` の `city_code` にあります
- メッシュの形と中心はメッシュコードから計算しています。原典の座標は単精度に丸められているため、使っていません（差は 1e-5 度以内です）

## テーブル（chizu スキーマ）

| テーブル | 内容 |
| --- | --- |
| `chizu.parcel` | 1 行が 1 筆。市区町村・大字・丁目・小字・地番、座標系、精度区分。公共座標の筆だけ形と代表点 |
| `chizu.source` | 取り込んだ zip。出典に書くデータセット名とページ URL |

使い方:

日野市の筆を座標系ごとに数える:

```sql
SELECT crs, count(*) AS parcels, count(geometry) AS with_shape
FROM geospatial.chizu.parcel
WHERE city_code = '13212'
GROUP BY crs;
```

### 筆の形と座標系

- 公共座標（平面直角座標系）の図面の筆だけが、形（`geometry`、経緯度 JGD2011）と代表点（`lng` / `lat`、筆の内側に取った点）を持ちます
- 任意座標系の図面の筆は図面の上の座標しかなく、地図に重ねられないため形が NULL です。形を持つ筆は全国で 47%、東京都では 1 割（区部 5%、市部 9%）です
- 筆の形は登記の境界を表すもので、建物や利用の区画ではありません
- 明治時代から現代までの図面が元になっていて、図面によって精度が違います（`accuracy`）。甲一・甲二・甲三・乙一・乙二・乙三の順に、甲に近く数字が小さいほど精度が高い区分です。任意座標系の筆はほとんど NULL です
- 形は原典をそのまま経緯度に変換したものです。自己交差する 0.3% の形は `ST_MakeValid` で修正しています

### 地番の注意

- 1 筆を示すキーは `(file, fude_id)` です。地番（市区町村・大字・丁目・小字・予備のコードと `chiban`）は一意になりません
- 番号のない土地（「道-1」「水-1」「無地番」など）は図面ごとに振られていて、同じ地番が別の図面に出てきます。数字の地番でも、任意座標系の図面と公共座標の図面の両方に同じ筆が載っていることがあります
- 地番に「地区外」「別図」とある筆は、その図面の外にある土地を指します
- 筆界未定地は地番が「筆界未定地-24」のような形で、もとの筆を `undetermined_members` に持ちます
- `city_name` は原典の市区町村名で、市町村合併の前の名前のことがあります

### 変換方法

地図 XML は [mojxml](https://github.com/MIERUNE/mojxml-py) で読み、公共座標を経緯度（JGD2011）に変換します。筆界未定地のもとの筆（筆界未定構成筆）は mojxml が読まないため、lxml で読み直してリストで持ちます。

各データセットには前年と当年の zip があり、新しい年のものだけを取得します。全国で zip が約 100GB あるため、取得した直後に Parquet にして zip は削除します。Parquet が既にある zip は取得し直しません。都道府県を絞るときは環境変数 `CHIZU_PREFECTURES`（都道府県コードのカンマ区切り）を使います。

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

`models/links/` の SQL と `*.table.yml` は `tools/generate_models.py` が作ります。手で直さず、`pipelines/links_tables.py`（テーブルとファイルの対応）か `tools/generate_models.py`（都道府県コードと geometry を付ける列）を直して作り直してください。
