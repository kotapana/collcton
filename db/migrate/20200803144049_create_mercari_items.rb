class CreateMercariItems < ActiveRecord::Migration[6.0]
  def change
    create_table :mercari_items do |t|
      t.string "item_url"
      t.string "item_title"
      t.string "item_category_large"
      t.string "item_category_medium"
      t.string "item_category_small"
      t.string "item_brand"
      t.string "item_size"
      t.string "item_status"
      t.string "item_delivery_fee_description"
      t.string "item_delivery_way"
      t.string "item_delivery_area"
      t.string "item_delivery_day"
      t.integer "item_fee"
      t.string "item_description"
      t.integer "item_good"
      t.string "user_name"
      t.string "user_url"
      t.boolean "item_sales", default: false, null: false
      t.timestamps
    end
  end
end
