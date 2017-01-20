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

ActiveRecord::Schema.define(version: 20170120033036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "example_non_examples", force: :cascade do |t|
    t.string   "text",       null: false
    t.string   "answer",     null: false
    t.string   "feedback",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id",    null: false
    t.integer  "word_id",    null: false
  end

  add_index "example_non_examples", ["answer"], name: "index_example_non_examples_on_answer", using: :btree
  add_index "example_non_examples", ["feedback"], name: "index_example_non_examples_on_feedback", unique: true, using: :btree
  add_index "example_non_examples", ["text", "answer", "feedback"], name: "index_example_non_examples_on_text_and_answer_and_feedback", unique: true, using: :btree
  add_index "example_non_examples", ["text"], name: "index_example_non_examples_on_text", unique: true, using: :btree
  add_index "example_non_examples", ["user_id"], name: "index_example_non_examples_on_user_id", using: :btree

  create_table "examples", force: :cascade do |t|
    t.string   "text",       null: false
    t.integer  "word_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "examples", ["word_id"], name: "index_examples_on_word_id", using: :btree

  create_table "freestyle_responses", force: :cascade do |t|
    t.string   "input",        null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_word_id"
    t.string   "focus"
  end

  create_table "game_stats", force: :cascade do |t|
    t.integer  "user_word_id",                                        null: false
    t.integer  "game_id",                                             null: false
    t.integer  "num_played",                            default: 0,   null: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "num_jeop_won",                          default: 0,   null: false
    t.integer  "num_jeop_lost",                         default: 0,   null: false
    t.decimal  "time_spent",    precision: 5, scale: 2, default: 0.0, null: false
  end

  add_index "game_stats", ["user_word_id", "game_id"], name: "index_game_stats_on_user_word_id_and_game_id", unique: true, using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "get_started_stats", force: :cascade do |t|
    t.integer  "get_started_top_btn",              default: 0
    t.integer  "get_started_btm_btn",              default: 0
    t.integer  "get_started_skip_btn",             default: 0
    t.integer  "get_started_goal_cont_btn",        default: 0
    t.integer  "get_started_goal_skip_btn",        default: 0
    t.integer  "get_started_mastery_circle_btn",   default: 0
    t.integer  "get_started_finish_btn",           default: 0
    t.integer  "get_started_save_my_progress_btn", default: 0
    t.integer  "get_started_create_my_acct_btn",   default: 0
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "meaning_alts", force: :cascade do |t|
    t.string   "text",       null: false
    t.integer  "word_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "feedback",   null: false
    t.string   "answer",     null: false
    t.string   "choices"
    t.integer  "user_id"
  end

  add_index "meaning_alts", ["word_id", "text"], name: "index_meaning_alts_on_word_id_and_text", unique: true, using: :btree
  add_index "meaning_alts", ["word_id"], name: "index_meaning_alts_on_word_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "user_tags", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_tags", ["tag_id"], name: "index_user_tags_on_tag_id", using: :btree
  add_index "user_tags", ["user_id", "tag_id"], name: "index_user_tags_on_user_id_and_tag_id", unique: true, using: :btree
  add_index "user_tags", ["user_id"], name: "index_user_tags_on_user_id", using: :btree

  create_table "user_word_tags", force: :cascade do |t|
    t.integer  "word_tag_id", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_word_tags", ["user_id", "word_tag_id"], name: "index_user_word_tags_on_user_id_and_word_tag_id", unique: true, using: :btree
  add_index "user_word_tags", ["user_id"], name: "index_user_word_tags_on_user_id", using: :btree
  add_index "user_word_tags", ["word_tag_id"], name: "index_user_word_tags_on_word_tag_id", using: :btree

  create_table "user_words", force: :cascade do |t|
    t.integer  "user_id",                     null: false
    t.integer  "word_id",                     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "games_completed", default: 0, null: false
  end

  add_index "user_words", ["user_id", "word_id"], name: "index_user_words_on_user_id_and_word_id", unique: true, using: :btree
  add_index "user_words", ["user_id"], name: "index_user_words_on_user_id", using: :btree
  add_index "user_words", ["word_id"], name: "index_user_words_on_word_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",                                   null: false
    t.string   "password_digest"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "role",                  default: "brainiac", null: false
    t.integer  "points",                default: 0,          null: false
    t.datetime "last_login"
    t.integer  "goal"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "num_logins",            default: 0,          null: false
    t.string   "login_history",         default: "",         null: false
    t.integer  "num_flashcards_played", default: 0,          null: false
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "word_antonyms", force: :cascade do |t|
    t.integer  "word_id",    null: false
    t.integer  "antonym_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "word_antonyms", ["antonym_id"], name: "index_word_antonyms_on_antonym_id", using: :btree
  add_index "word_antonyms", ["word_id", "antonym_id"], name: "index_word_antonyms_on_word_id_and_antonym_id", unique: true, using: :btree
  add_index "word_antonyms", ["word_id"], name: "index_word_antonyms_on_word_id", using: :btree

  create_table "word_synonyms", force: :cascade do |t|
    t.integer  "word_id",    null: false
    t.integer  "synonym_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "word_synonyms", ["synonym_id"], name: "index_word_synonyms_on_synonym_id", using: :btree
  add_index "word_synonyms", ["word_id", "synonym_id"], name: "index_word_synonyms_on_word_id_and_synonym_id", unique: true, using: :btree
  add_index "word_synonyms", ["word_id"], name: "index_word_synonyms_on_word_id", using: :btree

  create_table "word_tags", force: :cascade do |t|
    t.integer  "word_id",    null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "word_tags", ["tag_id"], name: "index_word_tags_on_tag_id", using: :btree
  add_index "word_tags", ["word_id", "tag_id"], name: "index_word_tags_on_word_id_and_tag_id", unique: true, using: :btree
  add_index "word_tags", ["word_id"], name: "index_word_tags_on_word_id", using: :btree

  create_table "words", force: :cascade do |t|
    t.string   "definition",        null: false
    t.string   "phonetic_spelling"
    t.string   "part_of_speech"
    t.string   "name",              null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "words", ["name", "definition"], name: "index_words_on_name_and_definition", using: :btree
  add_index "words", ["name"], name: "index_words_on_name", using: :btree

end
