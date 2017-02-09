class AddColumnUserWordsCountUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_words_count, :integer, default: 0
  end
end
