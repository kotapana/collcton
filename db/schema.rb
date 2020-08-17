# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_15_022607) do

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "large_category"
    t.string "medium_category"
    t.string "small_category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mercari_item_images", force: :cascade do |t|
    t.integer "mercari_item_id"
    t.string "item_image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mercari_item_id"], name: "index_mercari_item_images_on_mercari_item_id"
  end

  create_table "mercari_items", force: :cascade do |t|
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "merge_mercari_categories", force: :cascade do |t|
    t.string "mercari_item_category_large"
    t.string "mercari_item_category_medium"
    t.string "mercari_item_category_small"
    t.string "category_large"
    t.string "category_medium"
    t.string "category_small"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
