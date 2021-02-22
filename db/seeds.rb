# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@admin',
  password: 'adminadmin'
)

Customer.create!(
    [
      {
        email: '9988@9988',
        password: '99889988',
        name: 'ジャックマー',
        postal_code: "1040031",
        address: "東京都中央区京橋2-2-1京橋エドグラン27F",
      },
      {
        email: '0700@0700',
        password: '07000700',
        name: 'ポニーマー',
        postal_code: "1056329",
        address: "東京都港区虎ノ門1-23-1虎ノ門ヒルズ森タワー 29階",
      }
    ]
)

  Genre.create!(
    [
      {
        name: "電化製品",
        image: open("./app/assets/images/electrical_appliances.jpg")
      },
      {
        name: "化粧品",
        image: open("./app/assets/images/cosmetics.jpg")
      },
      {
        name: "食品",
        image: open("./app/assets/images/food.jpg")
      },
      {
        name: "衣服",
        image: open("./app/assets/images/clothes.jpg")
      }
    ]
  )

  Item.create!(
    [
      {
        genre_id: 1,
        name: "電子レンジ",
        detail: "最新モデルの電子レンジです。",
        image: open("./app/assets/images/microwave.jpg")
      },
      {
        genre_id: 1,
        name: "洗濯機",
        detail: "全自動式の洗濯機です。",
        image: open("./app/assets/images/washing_machine.jpg")
      },
      {
        genre_id: 1,
        name: "パソコン",
        detail: "最新のチップが組み込まれたパソコンです。",
        image: open("./app/assets/images/pc.jpg")
      },
      {
        genre_id: 1,
        name: "ヘッドホン",
        detail: "無線で繋げるヘッドホンです。",
        image: open("./app/assets/images/headphone.jpg")
      },
            {
        genre_id: 2,
        name: "香水",
        detail: "ウッディな香りです。",
        image: open("./app/assets/images/perfume.jpg")
      },
      {
        genre_id: 2,
        name: "ハンドクリーム",
        detail: "韓国で有名なハンドクリームです。",
        image: open("./app/assets/images/handcream.jpg")
      },
      {
        genre_id: 2,
        name: "マスカラ",
        detail: "まつ毛が爆上がりします。",
        image: open("./app/assets/images/mascara.jpg")
      },
      {
        genre_id: 2,
        name: "リップ",
        detail: "ツヤ感の出るリップです。",
        image: open("./app/assets/images/lip.jpg")
      },
      {
        genre_id: 3,
        name: "ハンバーガー",
        detail: "ニューヨーク創業のハンバーガーです。",
        image: open("./app/assets/images/hamburger.jpg")
      },
      {
        genre_id: 3,
        name: "パスタ",
        detail: "イタリア産のトマトを使用したパスタです。",
        image: open("./app/assets/images/pasta.jpg")
      },
      {
        genre_id: 3,
        name: "寿司",
        detail: "築地から仕入れたネタで握っています。",
        image: open("./app/assets/images/sushi.jpg")
      },
      {
        genre_id: 3,
        name: "ラーメン",
        detail: "魚介とんこつラーメンです。",
        image: open("./app/assets/images/ramen.jpg")
      },
      {
        genre_id: 4,
        name: "Tシャツ",
        detail: "ブランドのTシャツです。",
        image: open("./app/assets/images/t_shirts.jpg")
      },
      {
        genre_id: 4,
        name: "ジャケット",
        detail: "生地のシルクを使ったジャケットです。",
        image: open("./app/assets/images/jacket.jpg")
      },
      {
        genre_id: 4,
        name: "デニム",
        detail: "老舗デニムメーカーのデニムを使っています。",
        image: open("./app/assets/images/denim.jpg")
      },
      {
        genre_id: 4,
        name: "Yシャツ",
        detail: "シワがつきにくいYシャツです。",
        image: open("./app/assets/images/y_shirts.jpg")
      }
    ]
  )
  
  # Review.create!(
  #   [
  #     {
  #       customer_id: 1,
  #       item_id: 1,
  #       value: 1,
  #       good_point: "ない",
  #       bad_point: "高い、ダサい、機能がショボすぎる",
  #       improvement_point: "全部",
  #     }
  #   ]
  # )
  
require "csv"

CSV.foreach('db/review.csv', headers: true) do |row|
  Review.create(
    customer_id: row['customer_id'],
    item_id: row['item_id'],
    value: row['value'],
    good_point: row['good_point'],
    bad_point: row['bad_point'],
    improvement_point: row['improvement_point'],
  )
end