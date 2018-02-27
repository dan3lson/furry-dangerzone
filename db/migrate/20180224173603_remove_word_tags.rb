class RemoveWordTags < ActiveRecord::Migration
  def up
    drop_table "word_tags", force: :cascade do |t|
      t.integer  "word_id",    null: false
      t.integer  "tag_id",     null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end

  def down
    create_table "word_tags", force: :cascade do |t|
      t.integer  "word_id",    null: false
      t.integer  "tag_id",     null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
