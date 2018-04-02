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

ActiveRecord::Schema.define(version: 20180402100544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer "coin", null: false
    t.string "address", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin", "address"], name: "index_addresses_on_coin_and_address", unique: true
  end

  create_table "txs", force: :cascade do |t|
    t.bigint "address_id"
    t.decimal "amount"
    t.integer "confirmations"
    t.string "tx_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_index"
    t.index ["address_id", "tx_id"], name: "index_txs_on_address_id_and_tx_id", unique: true
    t.index ["address_id"], name: "index_txs_on_address_id"
    t.index ["block_index"], name: "index_txs_on_block_index"
    t.index ["confirmations"], name: "index_txs_on_confirmations"
  end

  add_foreign_key "txs", "addresses"
end
