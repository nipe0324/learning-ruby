# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140730051117) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", force: true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["category_id"], name: "index_categorizations_on_category_id"
  add_index "categorizations", ["product_id"], name: "index_categorizations_on_product_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "price"
    t.date     "released_on"
    t.integer  "rating"
    t.boolean  "discontinued", default: false, null: false
    t.integer  "publisher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["publisher_id"], name: "index_products_on_publisher_id"

  create_table "publishers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
