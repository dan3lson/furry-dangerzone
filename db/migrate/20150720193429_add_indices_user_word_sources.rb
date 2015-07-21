class AddIndicesUserWordSources < ActiveRecord::Migration
  def change
    add_index :user_word_sources, :user_id
    add_index :user_word_sources, :word_source_id
    add_index :user_word_sources, [:user_id, :word_source_id], unique: true
  end
end
