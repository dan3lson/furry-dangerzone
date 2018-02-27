class DropTableUserWordTags < ActiveRecord::Migration
  def up
    drop_table "user_word_tags", force: :cascade do |t|
      t.integer  "word_tag_id", null: false
      t.integer  "user_id",     null: false
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end
  end

  def down
    create_table "user_word_tags", force: :cascade do |t|
      t.integer  "word_tag_id", null: false
      t.integer  "user_id",     null: false
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end
  end
end
