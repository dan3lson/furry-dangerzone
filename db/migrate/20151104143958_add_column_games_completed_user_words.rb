class AddColumnGamesCompletedUserWords < ActiveRecord::Migration
  def change
    add_column :user_words, :games_completed, :integer, default: 0, null: false
  end
end
