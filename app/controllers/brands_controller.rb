class BrandsController < SearchController
  def index
    @brands = Brand.order(name: :ASC).page(params[:page]).per(1000)
  end

  def show
    super
    @brands = Brand.where(id: params[:id])

    # title,h1,description用
    @brands.each do |brand|
      brand_name = brand.name

      # 検索結果をカテゴリーに絞る用
      @mercari_items = MercariItem.joins(:mercari_item_images).select("mercari_items.*, mercari_item_images.*").where("item_brand like ?", "%#{brand_name}%").group(:id)

      # Kaminariによるpagination用
      @mercari_items = @mercari_items.page(params[:page]).per(60)
      @pagination_count_str = params[:page]
      @pagination_count_int = params[:page].to_i
  
      # ページ毎の表示件数を表示する用(ページ毎の表示数が変わる場合は変更してください。)
      @item_numbers_end = @pagination_count_int * 60
      @item_numbers_start = @pagination_count_int * 60 - 59
      if @item_numbers_start >= 0
        @item_numbers = "#{@item_numbers_start.to_s(:delimited)}〜#{@item_numbers_end.to_s(:delimited)}件"
      else
        @item_numbers = "1〜60件"
      end

      # category毎にh1,title,descriotionを生成する用
      if @pagination_count_int > 1
        @title = "【#{brand_name}】人気の中古品一覧(#{@pagination_count_str}ページ目) | Collecton"
        @h1 = "#{brand_name}の中古品一覧(#{@pagination_count_str}ページ目)"
        @description = "#{brand_name}の中古品をご紹介(#{@pagination_count_str}ページ目)！#{brand_name}の人気アイテムや限定アイテムの中古品をお得に探せます。お気に入りのアイテムを中古品から探しましょう！"
      else
        @title = "【#{brand_name}】人気の中古品一覧 | Collecton"
        @h1 = "#{brand_name}の中古品一覧"
        @description = "#{brand_name}の中古品をご紹介！#{brand_name}の人気アイテムや限定アイテムの中古品をお得に探せます。お気に入りのアイテムを中古品から探しましょう！"
      end

      # 全体の件数を数える用
      @mercari_item_all_count = MercariItem.where("item_brand like ?", "%#{@large_category}%").where("item_brand like ?", "%#{brand_name}%").count

    end
  end
end
