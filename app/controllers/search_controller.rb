class SearchController < ApplicationController
  def show
    # 商品ステータスのチェックボックス用
    @mercari_item_categories = MercariItem.group(:item_status).drop(1) # item_statusの配列にどうしても""となっている要素を持ってきてしまう。よって、dropで1つ目の要素を無理やり削除している
    
    @mercari_item_category_ids = (params[:mercari_item_category_id].presence || []).reject(&:blank?)

    @mercari_items = MercariItem.joins(:mercari_item_images).select("mercari_items.*, mercari_item_images.*").group(:id).order(created_at: :DESC)

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

    # title,description用
    @description = ""
    if @pagination_count_int > 1
      @h1 = "中古品の検索結果一覧(#{@pagination_count_str}ページ目)"
      @title = "Collecton - 中古品の検索結果(#{@pagination_count_str}ページ目)"
    else
      @h1 = "中古品の検索結果一覧"
      @title = "Collecton - 中古品の検索結果"
    end

    if @mercari_item_category_ids.present?
      @mercari_items = @mercari_items.where(item_status: @mercari_item_category_ids)
    end

    # キーワード検索用
    if params[:keyword].present?
      @mercari_items = @mercari_items.where("item_title like ?", "%#{params[:keyword]}%")
    end

    # ブランド検索用
    if params[:brand].present?
      @mercari_items = @mercari_items.where("item_brand like ?", "%#{params[:brand]}%")
    end

    # 価格検索用
    if params[:price_min].present?
      @mercari_items = @mercari_items.where("item_fee >= ?", params[:price_min])
    end

    if params[:price_max].present?
      @mercari_items = @mercari_items.where("item_fee <= ?", params[:price_max])
    end

    # 並び替え検索用
    if params[:sort].present?
      selection = params[:sort]
      case selection
      when 'new'
        return @mercari_items = @mercari_items.order(created_at: :DESC)
      when 'reasonable'
        return @mercari_items = @mercari_items.order(item_fee: :ASC)
      when 'luxury'
        return @mercari_items = @mercari_items.order(item_fee: :DESC)
      when 'likes'
        return @mercari_items = @mercari_items.order(item_good: :DESC)
      end
    end

    # 全体の件数を数える用
    @mercari_item_all_count = MercariItem.count.to_s(:delimited)
  end

  private

  def selected_checked_params
    params.require(:mercari_items)
  end
end
