"""Project LINKS の公開データのうち、テーブルにするファイルの一覧。

G空間情報センターの組織 sosei-joho（国土交通省 総合政策局 情報政策課）のデータセット（CKAN の package）と、
その中のファイル名の先頭（01_ など）で指す。同じ内容を後の年度のデータセットが含み直しているもの
（自動車運送事業の事故の統合データ、無人航空機の事故等報告）は、後の年度のファイルだけを使う。
"""

from typing import NamedTuple


class Source(NamedTuple):
    table: str
    package: str
    prefix: str
    title: str


TABLES = [
    # 観光統計データ（2025年度）
    Source("tourism_accommodation_guests", "links_kankoutoukei_2025", "01_", "宿泊旅行統計調査（都道府県別の延べ宿泊者数）"),
    Source("tourism_spending_overnight", "links_kankoutoukei_2025", "02_", "旅行・観光消費動向調査（宿泊旅行）"),
    Source("tourism_spending_day_trip", "links_kankoutoukei_2025", "03_", "旅行・観光消費動向調査（日帰り旅行）"),
    # 無人航空機飛行計画データ
    Source("drone_accidents", "links-mujinkoukuukihikoukeikaku-2025_", "02_", "無人航空機の事故等報告"),
    Source("drone_airspace_airport_vicinity", "links-mujinkoukuukihikoukeikaku-2024", "03_", "空港等の周辺空域"),
    Source("drone_airspace_yellow_zone", "links-mujinkoukuukihikoukeikaku-2024", "04_", "小型無人機等飛行禁止法のイエローゾーン"),
    Source("drone_airspace_red_zone", "links-mujinkoukuukihikoukeikaku-2024", "05_", "小型無人機等飛行禁止法のレッドゾーン"),
    # 一般旅客自動車運送事業関連データ（2025年度）
    Source("bus_route_transport_results", "links-ippanryokyaku-2025", "01_", "一般乗合旅客自動車運送事業輸送実績報告（路線バス）"),
    Source("bus_charter_transport_results", "links-ippanryokyaku-2025", "02_", "一般貸切旅客自動車運送事業輸送実績報告（貸切バス）"),
    Source("taxi_transport_results", "links-ippanryokyaku-2025", "03_", "一般乗用旅客自動車運送事業輸送実績報告（タクシー・ハイヤー）"),
    Source("passenger_motor_carrier_overview", "links-ippanryokyaku-2025", "04_", "一般旅客自動車運送事業の事業概況報告（乗合・貸切・乗用）"),
    # 自家用有償旅客運送データ（2025年度）
    Source("rideshare_transport_results", "links-rideshare-2025", "01_", "自家用有償旅客運送輸送実績報告書"),
    Source("rideshare_registry", "links-rideshare-2025", "02_", "自家用有償旅客運送者登録簿"),
    # 貸渡実績報告書データ（2025年度）
    Source("rental_car_results", "links-rentacars-2025", "01_", "貸渡実績報告書（レンタカー）"),
    Source("rental_car_office_vehicles", "links-rentacars-2025", "02_", "事務所別車種別配置車両数一覧（レンタカー）"),
    # 貨物自動車運送事業データ
    Source("trucking_business_results", "links-kamotsujidousyaunsojigyo-2024", "01_", "貨物自動車運送事業の事業実績報告書（全国、2015〜2022年度）"),
    Source("trucking_business_results_financials", "links-kamotsujidousyaunsojigyo-2024", "02_", "貨物自動車運送事業の事業実績と財務情報（全国のサンプル）"),
    Source("trucking_business_results_nara", "links-kamotsujidousyaunsojigyo-2025", "01_", "貨物自動車運送事業の事業実績報告書（奈良運輸支局管内、2023年度）"),
    Source("trucking_financials_nara", "links-kamotsujidousyaunsojigyo-2025", "02_", "貨物自動車運送事業の財務情報（奈良運輸支局管内、2023年度）"),
    # 自動車運送事業事故データ
    Source("motor_carrier_accidents", "links-jidousyaunsoujigyoujiko-2025", "01_", "自動車運送事業の事故報告書と交通事故統計の統合データ"),
    Source("motor_carrier_accident_reports", "links-jidousyaunsoujigyoujiko-2024", "02_", "自動車運送事業の事故報告書"),
    # 鉄道輸送実績・財務関連データ（2025年度）
    Source("railway_transport_volume", "links-tetsudoujigyou-2025", "01_", "鉄道統計年報 運輸成績表（数量）"),
    Source("railway_transport_distance", "links-tetsudoujigyou-2025", "02_", "鉄道統計年報 運輸成績表（延日キロ等）"),
    Source("railway_operating_kilometers", "links-tetsudoujigyou-2025", "03_", "鉄道統計年報 営業キロ及び走行キロ"),
    Source("railway_operating_profit", "links-tetsudoujigyou-2025", "04_", "鉄道統計年報 鉄軌道業営業損益"),
    Source("railway_income_statement", "links-tetsudoujigyou-2025", "05_", "鉄道統計年報 損益計算書"),
    Source("railway_balance_sheet", "links-tetsudoujigyou-2025", "06_", "鉄道統計年報 貸借対照表"),
    # 内航海運業データ
    Source("coastal_shipping_business_report", "links-naikoukaiungyou-2025", "01_", "内航海運業の事業概況報告（2025年度公開）"),
    Source("seafarer_business_status", "links-naikoukaiungyou-2025", "02_", "船員法第111条に基づく事業状況報告（関東運輸局管内）"),
    Source("seafarer_labor_survey_owned_ships", "links-naikoukaiungyou-2025", "03_", "船員労働統計調査 第一号調査"),
    Source("seafarer_labor_survey_other_ships", "links-naikoukaiungyou-2025", "04_", "船員労働統計調査 第二号調査"),
    Source("coastal_shipping_business_report_2024", "links-naikoukaiungyou-2024", "01_", "内航海運業の事業概況報告（2024年度公開）"),
    Source("coastal_shipping_operator_productivity", "links-naikoukaiungyou-2024", "02_", "内航船舶輸送統計調査による事業者別の生産性"),
    Source("port_survey", "links-naikoukaiungyou-2024", "03_", "港湾調査"),
    # 一般旅客定期航路事業データ（2024年度）
    Source("passenger_ferry_ships", "links-ippanryokyakuteikikourojigyou-2024", "01_", "一般旅客定期航路事業許可申請書（船舶）"),
    Source("ship_accidents", "links-ippanryokyakuteikikourojigyou-2024", "02_", "船舶事故等調査報告書"),
    Source("marine_forecast_areas", "links-ippanryokyakuteikikourojigyou-2024", "03_", "地方海上予報区（海域ポリゴン）"),
    # モーダルシフト関連データ（2024年度）
    Source("coastal_shipping_port_pairs", "links-modalshift-2024", "01_", "内航船舶輸送統計調査（積地・揚地の港の組）"),
    Source("truck_freight_prefecture_pairs", "links-modalshift-2024", "02_", "自動車輸送統計調査（発地・着地の都道府県の組）"),
    # 倉庫業データ
    Source("warehouse_registrations", "links-soukogyou-2024", "01_", "倉庫業登録申請書と倉庫明細書（中部運輸局管内）"),
    Source("warehouse_quarterly_usage", "links-soukogyou-2025", "01_", "期末倉庫使用状況報告書（全国、2019〜2024年度）"),
    Source("warehouse_quarterly_usage_2024", "links-soukogyou-2024", "02_", "期末倉庫使用状況報告書（2024年度公開）"),
    Source("warehouse_business_status", "links-soukogyou-2025", "02_", "倉庫事業経営状況報告書"),
    # 空き家・空き地バンク登録物件および成約物件データ（2025年度）
    Source("vacant_house_bank_listings", "links-akiyabank-2025", "01_", "全国版空き家・空き地バンクの登録物件"),
    Source("vacant_house_bank_contracts", "links-akiyabank-2025", "02_", "全国版空き家・空き地バンクの成約物件"),
]

PACKAGES = sorted({s.package for s in TABLES})
