class CategoriesController < SearchController
  def index
    @categories = Category.all
  end

  def show
    super
    # breadcrumbを作る用_large_category
    @categories = Category.where(id:params[:id])
    @categories.each do |large|
      @large_category = large.large_category
    end
    @breadcrumb_large = Category.where("large_category like ?", "%#{@large_category}%").first

    # breadcrumbを作る用_medium_category
    @categories.each do |medium|
      @medium_category = medium.medium_category
    end
    @breadcrumb_medium = Category.where("medium_category like ?", "%#{@medium_category}%").first

    # breadcrumbを作る用_small_category
    @categories.each do |small|
      @small_category = small.small_category
    end

    # 検索結果をカテゴリーに絞る用
    @mercari_items = MercariItem.joins(:mercari_item_images).select("mercari_items.*, mercari_item_images.*").where("item_category_large like ?", "%#{@large_category}%").where("item_category_medium like ?", "%#{@medium_category}%").where("item_category_small like ?", "%#{@small_category}%").group(:id)

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
      if @medium_category == ""
        @h1 = "#{@large_category}向けの中古品一覧(#{@pagination_count_str}ページ目)"
        @title = "#{@large_category}向けの中古品一覧(#{@pagination_count_str}ページ目) | collecton"
        @description = "#{@large_category}向けの中古品をご紹介(#{@pagination_count_str}ページ目)！人気アイテムや高級ブランドの#{@large_category}向けの中古品をお得に探せます！お気に入りのアイテムを中古品から探しましょう！"
      elsif @small_category == ""
        @h1 = "#{@large_category}向け#{@medium_category}の中古品一覧(#{@pagination_count_str}ページ目)"
        @title = "【#{@medium_category}】#{@large_category}に人気の中古品一覧(#{@pagination_count_str}ページ目) | collecton"
        @description = "#{@large_category}向け#{@medium_category}の中古品をご紹介(#{@pagination_count_str}ページ目)！人気アイテムや高級ブランドの#{@large_category}向け#{@medium_category}の中古品をお得に探せます！お気に入りのアイテムを中古品から探しましょう！"
      else
        @h1 = "#{@large_category}向け#{@small_category}の中古品一覧(#{@pagination_count_str}ページ目)"
        @title = "【#{@small_category}】#{@large_category}におすすめな中古品一覧(#{@pagination_count_str}ページ目) | collecton"
        @description = "#{@large_category}向け#{@small_category}の中古品をご紹介(#{@pagination_count_str}ページ目)！人気アイテムや高級ブランドの#{@large_category}向け#{@small_category}の中古品をお得に探せます！お気に入りのアイテムを中古品から探しましょう！"
      end
    else
      if @medium_category == ""
        @h1 = "#{@large_category}向けの中古品一覧"
        @title = "#{@large_category}向けの中古品一覧 | collecton"
        @description = "#{@large_category}向けの中古品をご紹介！人気アイテムや高級ブランドの#{@large_category}向けの中古品をお得に探せます！お気に入りのアイテムを中古品から探しましょう！"
      elsif @small_category == ""
        @h1 = "#{@large_category}向け#{@medium_category}の中古品一覧"
        @title = "【#{@medium_category}】#{@large_category}に人気の中古品一覧 | collecton"
        @description = "#{@large_category}向け#{@medium_category}の中古品をご紹介！人気アイテムや高級ブランドの#{@large_category}向け#{@medium_category}の中古品をお得に探せます！お気に入りのアイテムを中古品から探しましょう！"
      else
        @h1 = "#{@large_category}向け#{@small_category}の中古品一覧"
        @title = "【#{@small_category}】#{@large_category}におすすめな中古品一覧 | collecton"
        @description = "#{@large_category}向け#{@small_category}の中古品をご紹介！人気アイテムや高級ブランドの#{@large_category}向け#{@small_category}の中古品をお得に探せます！お気に入りのアイテムを中古品から探しましょう！"
      end
    end

    # 全体の件数を数える用
    @mercari_item_all_count = MercariItem.where("item_category_large like ?", "%#{@large_category}%").where("item_category_medium like ?", "%#{@medium_category}%").where("item_category_small like ?", "%#{@small_category}%").count

  end
end
