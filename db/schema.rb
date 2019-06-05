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

ActiveRecord::Schema.define(version: 2019_05_28_234736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.integer "vnum", null: false
    t.string "keywords", null: false
    t.string "item_type", null: false
    t.string "short_desc", null: false
    t.string "long_desc", null: false
    t.text "full_desc"
    t.string "action_desc"
    t.text "flags", default: [], array: true
    t.text "wear_flags", default: [], array: true
    t.text "magic_flags", default: [], array: true
    t.integer "value0", default: 0
    t.integer "value1", default: 0
    t.integer "value2", default: 0
    t.integer "value3", default: 0
    t.integer "value4", default: 0
    t.integer "value5", default: 0
    t.integer "weight", default: 0
    t.integer "cost", default: 0
    t.integer "rent", default: 0
    t.integer "level", default: 0
    t.integer "layers", default: 0
    t.string "spells", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vnum"], name: "index_items_on_vnum", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.integer "rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "socials", force: :cascade do |t|
    t.string "name", null: false
    t.text "char_no_arg", null: false
    t.text "others_no_arg"
    t.text "char_obj"
    t.text "others_obj"
    t.text "char_found"
    t.text "others_found"
    t.text "vict_found"
    t.text "char_auto"
    t.text "others_auto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_socials_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.string "pronoun_class", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role_id", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "zones", force: :cascade do |t|
    t.string "name", null: false
    t.string "filename", null: false
    t.string "author", null: false
    t.bigint "owner_id"
    t.integer "min_vnum", null: false
    t.integer "max_vnum", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_zones_on_owner_id"
  end

  add_foreign_key "zones", "users", column: "owner_id"
end
