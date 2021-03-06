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

ActiveRecord::Schema.define(version: 20180224180458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "action",         null: false
    t.integer  "user_id",        null: false
    t.integer  "trackable_id",   null: false
    t.string   "trackable_type", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "activities", ["action"], name: "index_activities_on_action", using: :btree
  add_index "activities", ["trackable_id"], name: "index_activities_on_trackable_id", using: :btree
  add_index "activities", ["trackable_type"], name: "index_activities_on_trackable_type", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "classrooms", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "grade",      null: false
  end

  add_index "classrooms", ["name", "teacher_id"], name: "index_classrooms_on_name_and_teacher_id", unique: true, using: :btree
  add_index "classrooms", ["name"], name: "index_classrooms_on_name", using: :btree
  add_index "classrooms", ["teacher_id"], name: "index_classrooms_on_teacher_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body",             null: false
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree

  create_table "describe_mes", force: :cascade do |t|
    t.string   "text",       null: false
    t.integer  "word_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "freestyle_desc_mes", force: :cascade do |t|
    t.integer  "freestyle_id",   null: false
    t.integer  "describe_me_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "freestyle_desc_mes", ["describe_me_id"], name: "index_freestyle_desc_mes_on_describe_me_id", using: :btree
  add_index "freestyle_desc_mes", ["freestyle_id"], name: "index_freestyle_desc_mes_on_freestyle_id", using: :btree

  create_table "freestyle_ex_non_exes", force: :cascade do |t|
    t.integer  "freestyle_id", null: false
    t.string   "kind",         null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "freestyle_ex_non_exes", ["freestyle_id"], name: "index_freestyle_ex_non_exes_on_freestyle_id", using: :btree

  create_table "freestyle_lek_tales", force: :cascade do |t|
    t.integer  "freestyle_id", null: false
    t.text     "word_ids",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "freestyle_rel_words", force: :cascade do |t|
    t.integer  "freestyle_id", null: false
    t.integer  "rel_word_id",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "freestyle_sent_stems", force: :cascade do |t|
    t.integer  "freestyle_id", null: false
    t.integer  "sent_stem_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "freestyle_sent_stems", ["freestyle_id"], name: "index_freestyle_sent_stems_on_freestyle_id", using: :btree
  add_index "freestyle_sent_stems", ["sent_stem_id"], name: "index_freestyle_sent_stems_on_sent_stem_id", using: :btree

  create_table "freestyles", force: :cascade do |t|
    t.text     "input",                                 null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "user_word_id",                          null: false
    t.string   "status",       default: "not reviewed", null: false
  end

  create_table "game_stat_example_non_examples", force: :cascade do |t|
    t.integer  "game_stat_id",           null: false
    t.integer  "example_non_example_id", null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "game_stat_freestyle_desc_mes", force: :cascade do |t|
    t.integer  "game_stat_id",         null: false
    t.integer  "freestyle_desc_me_id", null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "game_stat_freestyle_desc_mes", ["freestyle_desc_me_id"], name: "index_game_stat_freestyle_desc_mes_on_freestyle_desc_me_id", using: :btree
  add_index "game_stat_freestyle_desc_mes", ["game_stat_id"], name: "index_game_stat_freestyle_desc_mes_on_game_stat_id", using: :btree

  create_table "game_stat_freestyle_lek_tales", force: :cascade do |t|
    t.integer  "game_stat_id",          null: false
    t.integer  "freestyle_lek_tale_id", null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "game_stat_freestyle_rel_words", force: :cascade do |t|
    t.integer  "game_stat_id",          null: false
    t.integer  "freestyle_rel_word_id", null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "game_stat_freestyle_sent_stems", force: :cascade do |t|
    t.integer  "game_stat_id",           null: false
    t.integer  "freestyle_sent_stem_id", null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "game_stat_freestyles", force: :cascade do |t|
    t.integer  "game_stat_id", null: false
    t.integer  "freestyle_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "game_stat_freestyles", ["freestyle_id"], name: "index_game_stat_freestyles_on_freestyle_id", using: :btree
  add_index "game_stat_freestyles", ["game_stat_id"], name: "index_game_stat_freestyles_on_game_stat_id", using: :btree

  create_table "game_stat_meaning_alts", force: :cascade do |t|
    t.integer  "game_stat_id",   null: false
    t.integer  "meaning_alt_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "game_stats", force: :cascade do |t|
    t.integer  "user_word_id", null: false
    t.integer  "game_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "time_started"
    t.datetime "time_ended"
  end

  create_table "games", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "games", ["name"], name: "index_games_on_name", using: :btree

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

  create_table "sent_stems", force: :cascade do |t|
    t.string   "text",       null: false
    t.integer  "word_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "user_word_user_tags", force: :cascade do |t|
    t.integer  "user_word_id", null: false
    t.integer  "user_tag_id",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "user_word_user_tags", ["user_tag_id"], name: "index_user_word_user_tags_on_user_tag_id", using: :btree
  add_index "user_word_user_tags", ["user_word_id", "user_tag_id"], name: "index_user_word_user_tags_on_user_word_id_and_user_tag_id", unique: true, using: :btree
  add_index "user_word_user_tags", ["user_word_id"], name: "index_user_word_user_tags_on_user_word_id", using: :btree

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
    t.string   "username",                      null: false
    t.string   "password_digest"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "type",                          null: false
    t.datetime "last_login"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "num_logins",       default: 0,  null: false
    t.string   "login_history",    default: "", null: false
    t.integer  "user_words_count", default: 0
    t.integer  "classroom_id"
    t.integer  "teacher_id"
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

  create_table "words", force: :cascade do |t|
    t.string   "definition",        null: false
    t.string   "phonetic_spelling"
    t.string   "part_of_speech"
    t.string   "name",              null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "photo"
    t.integer  "creator_id"
  end

  add_index "words", ["name", "definition"], name: "index_words_on_name_and_definition", unique: true, using: :btree
  add_index "words", ["name"], name: "index_words_on_name", using: :btree

  add_foreign_key "game_stat_freestyles", "freestyles"
  add_foreign_key "game_stat_freestyles", "game_stats"
end
