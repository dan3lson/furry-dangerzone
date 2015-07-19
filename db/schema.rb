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

ActiveRecord::Schema.define(version: 20150717175149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sources", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sources", ["name"], name: "index_sources_on_name", unique: true, using: :btree

  create_table "user_sources", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "source_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_words", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "word_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_words", ["user_id", "word_id"], name: "index_user_words_on_user_id_and_word_id", unique: true, using: :btree
  add_index "user_words", ["user_id"], name: "index_user_words_on_user_id", using: :btree
  add_index "user_words", ["word_id"], name: "index_user_words_on_word_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "word_sources", force: :cascade do |t|
    t.integer  "word_id",                null: false
    t.integer  "source_id",  default: 1, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "word_sources", ["source_id"], name: "index_word_sources_on_source_id", using: :btree
  add_index "word_sources", ["word_id", "source_id"], name: "index_word_sources_on_word_id_and_source_id", unique: true, using: :btree
  add_index "word_sources", ["word_id"], name: "index_word_sources_on_word_id", using: :btree

  create_table "words", force: :cascade do |t|
    t.string   "definition",        null: false
    t.string   "phonetic_spelling", null: false
    t.string   "part_of_speech",    null: false
    t.string   "name",              null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "example_sentence",  null: false
  end

  add_index "words", ["name"], name: "index_words_on_name", unique: true, using: :btree

end
