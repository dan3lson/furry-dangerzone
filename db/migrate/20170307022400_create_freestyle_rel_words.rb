class CreateFreestyleRelWords < ActiveRecord::Migration
  def change
    create_table :freestyle_rel_words do |t|
      t.integer :freestyle_id, null: false
      t.integer :rel_word_id, null: false
      t.timestamps null: false
    end
  end
end
