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

ActiveRecord::Schema.define(version: 20141130131318) do

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "scheme_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "constructions", force: true do |t|
    t.integer  "element_id"
    t.integer  "scheme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "users_title"
    t.integer  "parametrs_id"
    t.string   "tips"
  end

  create_table "elements", force: true do |t|
    t.string   "title"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "num_inputs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "parametrs", force: true do |t|
    t.string  "name"
    t.string  "value"
    t.integer "construction_id"
  end

  create_table "properties", force: true do |t|
    t.string   "title"
    t.string   "value",      default: "0"
    t.integer  "element_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", force: true do |t|
    t.integer  "user_id"
    t.integer  "scheme_id"
    t.decimal  "value",      precision: 11, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scheme_element_properties", force: true do |t|
    t.integer "construction_id"
    t.integer "property_id"
    t.string  "value"
  end

  create_table "schemes", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.float    "rating",                    limit: 24, default: 0.0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_description"
    t.boolean  "published",                            default: false
    t.string   "scheme_image_file_name"
    t.string   "scheme_image_content_type"
    t.integer  "scheme_image_file_size"
    t.datetime "scheme_image_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",               default: "",        null: false
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "role",                   default: "visitor", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
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
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "name"
    t.string   "theme"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
