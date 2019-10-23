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

ActiveRecord::Schema.define(version: 2019_10_23_030510) do

  create_table "shipping_providers", force: :cascade do |t|
    t.string "company", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rate_cents", default: 0, null: false
    t.string "rate_currency", default: "USD", null: false
    t.integer "common_rate_cents", default: 0, null: false
    t.string "common_rate_currency", default: "USD", null: false
  end

  create_table "shipping_rates", force: :cascade do |t|
    t.string "origin", null: false
    t.string "destination", null: false
    t.integer "shipping_provider_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rate_cents", default: 0, null: false
    t.string "rate_currency", default: "USD", null: false
    t.integer "common_rate_cents", default: 0, null: false
    t.string "common_rate_currency", default: "USD", null: false
    t.index ["shipping_provider_id"], name: "index_shipping_rates_on_shipping_provider_id"
  end

  add_foreign_key "shipping_rates", "shipping_providers"
end
