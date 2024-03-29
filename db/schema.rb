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

ActiveRecord::Schema.define(version: 2021_05_07_152824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "balance", precision: 8, scale: 2, default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "last_digits", limit: 4, null: false
    t.date "expiration_date", null: false
    t.string "holder_name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "expiration_month"
    t.integer "expiration_year"
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.bigint "from_account_id"
    t.bigint "to_account_id", null: false
    t.integer "status", null: false
    t.integer "transaction_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "credit_card_id"
    t.index ["credit_card_id"], name: "index_transactions_on_credit_card_id"
    t.index ["from_account_id"], name: "index_transactions_on_from_account_id"
    t.index ["to_account_id"], name: "index_transactions_on_to_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "transactions", "accounts", column: "from_account_id"
  add_foreign_key "transactions", "accounts", column: "to_account_id"
  add_foreign_key "transactions", "credit_cards"
end
