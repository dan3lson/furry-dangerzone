class RemoveColumnGamesCompletedUserWords < ActiveRecord::Migration
  def change
    remove_column :user_words, :games_completed, :integer
  end
end
