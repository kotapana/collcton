class HomeController < ApplicationController
  def index
    # title,description用
    @title = "Collecton - 中古品の最安値を探せる情報サイト"
    @description = "中古品の最安値を調べるならCollecton!有名ブランドから人気アイテムまで、幅広く網羅しています。価格、ブランド名、商品名、商品ジャンルなど様々な側面から検索できます。中古品の最安値を知りたいならCollectonで検索！"

    # カテゴリーへのリンク用
    @categories_women_medium = Category.where(large_category:"レディース").where(small_category:"").drop(1)
    @categories_men_medium = Category.where(large_category:"メンズ").where(small_category:"").drop(1)
    @brands = Brand.where.not(name:["スーパー","コンビニ","ハズキルーペ","ジャニーズ","スターバックス","ジョーカー","カルディ","無印良品","ミルクボーイ","ジルスチュアート","ジョジョ","アフタヌーンティー","ハピタス","フェリシモ","スヌーピー","スターウォーズ","アンドロイド"]).limit(20)

    # ブランドの件数を数える用
    @louisvuitton = MercariItem.where("item_brand like ?","%ヴィトン%").count
    @chanel = MercariItem.where("item_brand like ?","%シャネル%").count
    @hermes = MercariItem.where("item_brand like ?","%エルメス%").count
    @gucchi = MercariItem.where("item_brand like ?","%グッチ%").count
    @tiffany = MercariItem.where("item_brand like ?","%ティファニー%").count
    @dolcegabbana = MercariItem.where("item_brand like ?","%ドルチェ＆ガッバーナ%").count
    @supreme = MercariItem.where("item_brand like ?","%シュプリーム%").count
    @rolex = MercariItem.where("item_brand like ?","%ロレックス%").count
  end
end
