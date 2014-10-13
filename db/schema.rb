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

ActiveRecord::Schema.define(version: 20141013103805) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.string   "document_file_name"
    t.integer  "document_file_size"
    t.string   "document_content_type"
    t.datetime "document_updated_at"
    t.string   "document_fingerprint"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["documentable_id", "documentable_type"], name: "index_documents_on_documentable_id_and_documentable_type"

  create_table "offers", force: true do |t|
    t.text     "offer_technical"
    t.text     "offer_economical"
    t.datetime "delivery_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "procurement_id"
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "tech_eval"
  end

  add_index "offers", ["procurement_id"], name: "index_offers_on_procurement_id"
  add_index "offers", ["product_id"], name: "index_offers_on_product_id"
  add_index "offers", ["user_id"], name: "index_offers_on_user_id"

  create_table "procurement_products", id: false, force: true do |t|
    t.integer  "procurement_id", null: false
    t.integer  "product_id",     null: false
    t.string   "quantity"
    t.text     "requirements"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "procurements", force: true do |t|
    t.string   "name"
    t.date     "proc_start_date"
    t.date     "proc_end_date"
    t.text     "proc_terms"
    t.date     "proc_delivery_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "category"
  end

  add_index "procurements", ["user_id"], name: "index_procurements_on_user_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
