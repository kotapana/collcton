class RenameMercariItemsIdColumnToMercariItemImages < ActiveRecord::Migration[6.0]
  def change
    rename_column :mercari_item_images, :mercari_items_id, :mercari_item_id
  end
end
