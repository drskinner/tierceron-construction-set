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

ActiveRecord::Schema.define(version: 2019_07_18_170314) do

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

  create_table "mobiles", force: :cascade do |t|
    t.integer "vnum", null: false
    t.string "keywords", null: false
    t.string "short_desc", null: false
    t.string "long_desc", null: false
    t.text "description"
    t.string "race", null: false
    t.string "klass", null: false
    t.string "position", null: false
    t.string "defposition", null: false
    t.string "spec_funname"
    t.string "sex", null: false
    t.text "act_flags", default: [], array: true
    t.text "affected_by", default: [], array: true
    t.integer "alignment", null: false
    t.integer "level", null: false
    t.integer "mobthac0", null: false
    t.integer "ac", null: false
    t.integer "gold", null: false
    t.integer "exp", null: false
    t.integer "hitnodice", null: false
    t.integer "hitsizedice", null: false
    t.integer "hitplus", null: false
    t.integer "damnodice", null: false
    t.integer "damsizedice", null: false
    t.integer "damplus", null: false
    t.integer "height", null: false
    t.integer "weight", null: false
    t.integer "numattacks", null: false
    t.integer "hitroll", null: false
    t.integer "damroll", null: false
    t.integer "saving_poison_death", default: 0
    t.integer "saving_wand", default: 0
    t.integer "saving_para_petri", default: 0
    t.integer "saving_breath", default: 0
    t.integer "saving_spell_staff", default: 0
    t.integer "str", default: 13
    t.integer "int", default: 13
    t.integer "wis", default: 13
    t.integer "dex", default: 13
    t.integer "con", default: 13
    t.integer "cha", default: 13
    t.integer "lck", default: 13
    t.text "speaks", default: [], array: true
    t.text "speaking", default: [], array: true
    t.text "xflags", default: [], array: true
    t.text "resistant", default: [], array: true
    t.text "immune", default: [], array: true
    t.text "susceptible", default: [], array: true
    t.text "attacks", default: [], array: true
    t.text "defenses", default: [], array: true
    t.integer "shop_data", array: true
    t.integer "repair_data", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vnum"], name: "index_mobiles_on_vnum", unique: true
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
