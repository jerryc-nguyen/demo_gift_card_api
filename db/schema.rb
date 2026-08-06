# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2026_08_06_040804) do
  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
    t.string "website"
    t.string "logo_url"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_products", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "product_id"], name: "index_client_products_on_client_id_and_product_id", unique: true
    t.index ["client_id"], name: "index_client_products_on_client_id"
    t.index ["product_id"], name: "index_client_products_on_product_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "api_key"
    t.decimal "payout_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_key"], name: "index_clients_on_api_key", unique: true
  end

  create_table "gift_cards", force: :cascade do |t|
    t.integer "product_id"
    t.integer "client_id"
    t.string "activation_number"
    t.string "pin"
    t.string "purchase_details"
    t.integer "status", default: 0
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["activation_number"], name: "index_gift_cards_on_activation_number", unique: true
    t.index ["client_id"], name: "index_gift_cards_on_client_id"
    t.index ["deleted_at"], name: "index_gift_cards_on_deleted_at"
    t.index ["product_id"], name: "index_gift_cards_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "brand_id", null: false
    t.string "name"
    t.decimal "price"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "searchable_text"
    t.index ["brand_id"], name: "index_products_on_brand_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
