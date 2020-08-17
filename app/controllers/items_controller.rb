class ItemsController < ApplicationController
  def show
    # 商品のデータと画像を表示する用
    @mercari_item = MercariItem.find(params[:id])
    @mercari_item_images_first = MercariItemImage.where(mercari_item_id: params[:id]).order(created_at: :ASC).first
    @mercari_item_images_other = MercariItemImage.where(mercari_item_id: params[:id]).order(created_at: :ASC).drop(1)

    # title,description用
    @title = "#{@mercari_item.item_title} | Collecton"
    @description = "#{@mercari_item.item_description}"

    # パンくずを生成する用(Categoryにないmercariのcategoryだと、引っかからないため修正が必要)
    @merge_category = MergeMercariCategory.where("mercari_item_category_large like ?","%#{@mercari_item.item_category_large}%").where("mercari_item_category_medium like ?","%#{@mercari_item.item_category_medium}%").where("mercari_item_category_small like ?","%#{@mercari_item.item_category_small}%")
    @merge_category.each do |merge|
      @category_large = Category.where("large_category like ?","%#{merge.category_large}%").where(medium_category:"")
      @category_medium = Category.where("large_category like ?","%#{merge.category_large}%").where("medium_category like ?","%#{merge.category_medium}%").where(small_category:"")
      @category_small = Category.where("large_category like ?","%#{merge.category_large}%").where("medium_category like ?","%#{merge.category_medium}%").where("small_category like ?","%#{merge.category_small}%")
    end

    # カルーセルのデータ用
    @mercari_items_carousel_category_large = MercariItem.joins(:mercari_item_images).select("mercari_items.*, mercari_item_images.*").where("item_category_large like ?","%#{@mercari_item.item_category_large}%").group(:id).order(id: :DESC).limit(10)
    @mercari_items_carousel_category_medium = MercariItem.joins(:mercari_item_images).select("mercari_items.*, mercari_item_images.*").where("item_category_large like ?","%#{@mercari_item.item_category_large}%").where("item_category_medium like ?","%#{@mercari_item.item_category_medium}%").group(:id).order(id: :DESC).limit(10)
    @mercari_items_carousel_category_small = MercariItem.joins(:mercari_item_images).select("mercari_items.*, mercari_item_images.*").where("item_category_large like ?","%#{@mercari_item.item_category_large}%").where("item_category_medium like ?","%#{@mercari_item.item_category_medium}%").where("item_category_small like ?","%#{@mercari_item.item_category_small}%").group(:id).order(id: :DESC).limit(10)
    @mercari_items_carousel_brand = MercariItem.joins(:mercari_item_images).select("mercari_items.*, mercari_item_images.*").where("item_brand like ?","%#{@mercari_item.item_brand}%").group(:id).order(id: :DESC).limit(10)

    # カルーセルのブランドの『もっと見る』ボタン用
    @brand = Brand.where("name like ?","%#{@mercari_item.item_brand}%")
  end
end
