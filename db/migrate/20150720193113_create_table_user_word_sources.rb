class CreateTableUserWordSources < ActiveRecord::Migration
  def change
    create_table :user_word_sources do |t|
      t.integer :word_source_id, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
