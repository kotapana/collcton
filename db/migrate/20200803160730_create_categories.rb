class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :large_category
      t.string :medium_category
      t.string :small_category
      t.timestamps
    end
  end
end
