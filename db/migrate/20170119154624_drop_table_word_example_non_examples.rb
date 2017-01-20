class DropTableWordExampleNonExamples < ActiveRecord::Migration
  def up
    drop_table :word_example_non_examples
  end

  def down
    create_table "word_example_non_examples", force: :cascade do |t|
      t.integer  "word_id",                null: false
      t.integer  "example_non_example_id", null: false
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end
  end
end
