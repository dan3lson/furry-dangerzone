class AddIndicesToUserWords < ActiveRecord::Migration
  def change
    add_index :user_words, :user_id
    add_index :user_words, :word_id
    add_index :user_words, [:user_id, :word_id], unique: true
  end
end
