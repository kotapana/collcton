class CreateMergeMercariCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :merge_mercari_categories do |t|
      t.string "mercari_item_category_large"
      t.string "mercari_item_category_medium"
      t.string "mercari_item_category_small"
      t.string "category_large"
      t.string "category_medium"
      t.string "category_small"
      t.timestamps
    end
  end
end
