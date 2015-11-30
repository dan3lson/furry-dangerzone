class AddColumnNumFlashcardsPlayedUsers < ActiveRecord::Migration
  def change
    add_column :users, :num_flashcards_played, :integer, default: 0, null: false
  end
end
