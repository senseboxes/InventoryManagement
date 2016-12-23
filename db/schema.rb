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

ActiveRecord::Schema.define(version: 20161221043249) do

  create_table "inventories", force: :cascade do |t|
    t.string   "iname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monthaverages", force: :cascade do |t|
    t.string   "inven_name"
    t.integer  "january"
    t.integer  "february"
    t.integer  "march"
    t.integer  "april"
    t.integer  "may"
    t.integer  "june"
    t.integer  "july"
    t.integer  "august"
    t.integer  "september"
    t.integer  "october"
    t.integer  "november"
    t.integer  "december"
    t.integer  "january_c"
    t.integer  "february_c"
    t.integer  "march_c"
    t.integer  "april_c"
    t.integer  "may_c"
    t.integer  "june_c"
    t.integer  "july_c"
    t.integer  "august_c"
    t.integer  "september_c"
    t.integer  "october_c"
    t.integer  "november_c"
    t.integer  "december_c"
    t.integer  "y_sum"
    t.integer  "y_avg"
    t.integer  "m_avg"
    t.integer  "y_index"
    t.integer  "m_index"
    t.integer  "inventory_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["inventory_id"], name: "index_monthaverages_on_inventory_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "pname"
    t.integer  "puchase_kg"
    t.integer  "release_kg"
    t.integer  "stock_kg"
    t.integer  "predict"
    t.integer  "month_avg"
    t.string   "memo"
    t.integer  "inventory_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["inventory_id"], name: "index_products_on_inventory_id"
  end

end
