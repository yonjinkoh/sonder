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

ActiveRecord::Schema.define(version: 20151227004400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username",               default: "", null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "amazons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.string   "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "list_id"
    t.string   "published"
    t.string   "author"
  end

  add_index "books", ["list_id"], name: "index_books_on_list_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "api"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "list_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "category_id"
    t.string   "movie_number"
    t.integer  "user_id"
  end

  add_index "lists", ["user_id"], name: "index_lists_on_user_id", using: :btree

  create_table "lists_categories", force: :cascade do |t|
    t.integer "list_id"
    t.integer "part_id"
  end

  add_index "lists_categories", ["list_id"], name: "index_lists_categories_on_list_id", using: :btree
  add_index "lists_categories", ["part_id"], name: "index_lists_categories_on_part_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "name"
    t.string   "year"
    t.string   "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "list_id"
  end

  add_index "movies", ["list_id"], name: "index_movies_on_list_id", using: :btree

  create_table "quotes", force: :cascade do |t|
    t.string   "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "list_id"
    t.text     "content"
  end

  add_index "quotes", ["list_id"], name: "index_quotes_on_list_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "name"
    t.string   "artist"
    t.string   "album"
    t.string   "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "list_id"
  end

  add_index "songs", ["list_id"], name: "index_songs_on_list_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.text     "description"
    t.string   "picture"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "list_id"
    t.string   "avatar"
    t.boolean  "verified",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "books", "lists"
  add_foreign_key "categories", "lists", name: "categories_list_id_fk"
  add_foreign_key "lists", "users"
  add_foreign_key "movies", "lists"
  add_foreign_key "quotes", "lists"
  add_foreign_key "songs", "lists"
end
