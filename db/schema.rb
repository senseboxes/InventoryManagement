# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180208054207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", id: :serial, force: :cascade do |t|
    t.string "iname"
    t.integer "inputID"
    t.integer "categoryID"
    t.boolean "bool1"
    t.boolean "bool2"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.decimal "iST_KG", precision: 9, scale: 3
    t.index ["category_id"], name: "index_inventories_on_category_id"
  end

  create_table "invinfos", id: :serial, force: :cascade do |t|
    t.string "iiname"
    t.integer "iinputID"
    t.integer "icategoryID"
    t.boolean "ibool1"
    t.boolean "ibool2"
    t.text "itext"
    t.string "reserve1_s"
    t.string "reserve2_s"
    t.string "reserve3_s"
    t.string "reserve4_s"
    t.string "reserve5_s"
    t.integer "reserve1_i"
    t.integer "reserve2_i"
    t.integer "reserve3_i"
    t.integer "reserve4_i"
    t.integer "reserve5_i"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monthaverages", id: :serial, force: :cascade do |t|
    t.string "inven_name"
    t.decimal "january", precision: 10, scale: 3
    t.decimal "february", precision: 10, scale: 3
    t.decimal "march", precision: 10, scale: 3
    t.decimal "april", precision: 10, scale: 3
    t.decimal "may", precision: 10, scale: 3
    t.decimal "june", precision: 10, scale: 3
    t.decimal "july", precision: 10, scale: 3
    t.decimal "august", precision: 10, scale: 3
    t.decimal "september", precision: 10, scale: 3
    t.decimal "october", precision: 10, scale: 3
    t.decimal "november", precision: 10, scale: 3
    t.decimal "december", precision: 10, scale: 3
    t.integer "january_c"
    t.integer "february_c"
    t.integer "march_c"
    t.integer "april_c"
    t.integer "may_c"
    t.integer "june_c"
    t.integer "july_c"
    t.integer "august_c"
    t.integer "september_c"
    t.integer "october_c"
    t.integer "november_c"
    t.integer "december_c"
    t.decimal "y_sum", precision: 10, scale: 3
    t.decimal "y_avg", precision: 10, scale: 3
    t.decimal "m_avg", precision: 10, scale: 3
    t.integer "y_index"
    t.integer "m_index"
    t.integer "inventory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cat_ID"
    t.index ["inventory_id"], name: "index_monthaverages_on_inventory_id"
  end

  create_table "productnamesets", force: :cascade do |t|
    t.string "productname"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_productnamesets_on_category_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "pname"
    t.decimal "puchase_kg", precision: 10, scale: 3
    t.decimal "release_kg", precision: 10, scale: 3
    t.decimal "stock_kg", precision: 10, scale: 3
    t.decimal "predict", precision: 10, scale: 3
    t.decimal "month_avg", precision: 10, scale: 3
    t.string "memo"
    t.integer "inventory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_id"], name: "index_products_on_inventory_id"
  end

  add_foreign_key "inventories", "categories"
  add_foreign_key "monthaverages", "inventories"
  add_foreign_key "productnamesets", "categories"
  add_foreign_key "products", "inventories"
end
