class CreateMercariItemImages < ActiveRecord::Migration[6.0]
  def change
    create_table :mercari_item_images do |t|
      t.references :mercari_items, index: true
      t.string :item_image_url
      t.timestamps
    end
  end
end
