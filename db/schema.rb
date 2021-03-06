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

ActiveRecord::Schema.define(version: 20170915173551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contributions", force: :cascade do |t|
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "user_id"
    t.decimal  "naira_balance",     precision: 13, scale: 2
    t.decimal  "us_dollar_balance", precision: 13, scale: 2
    t.decimal  "gb_pound_balance",  precision: 13, scale: 2
  end

  add_index "contributions", ["user_id"], name: "index_contributions_on_user_id", using: :btree

  create_table "cooperative_accounts", force: :cascade do |t|
    t.string   "account_name"
    t.string   "account_type"
    t.decimal  "naira_balance", precision: 13, scale: 2
    t.decimal  "usd_balance",   precision: 13, scale: 2
    t.decimal  "gbp_balance",   precision: 13, scale: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.date     "birthday"
    t.text     "specialities"
    t.text     "in_network"
    t.text     "contact"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "status"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal  "amount",          precision: 13, scale: 2
    t.integer  "currency"
    t.integer  "creator_id"
    t.integer  "contribution_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "tran_type"
    t.integer  "status"
    t.integer  "verifier_id"
    t.string   "description"
    t.date     "tran_date"
    t.integer  "tranable_id"
    t.string   "tranable_type"
  end

  add_index "transactions", ["contribution_id"], name: "index_transactions_on_contribution_id", using: :btree
  add_index "transactions", ["creator_id"], name: "index_transactions_on_creator_id", using: :btree
  add_index "transactions", ["tranable_type", "tranable_id"], name: "index_transactions_on_tranable_type_and_tranable_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "phone"
    t.integer  "role_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "contributions", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "transactions", "contributions"
  add_foreign_key "transactions", "users", column: "creator_id"
  add_foreign_key "users", "roles"
end
