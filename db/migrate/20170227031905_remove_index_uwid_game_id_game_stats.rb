class RemoveIndexUwidGameIdGameStats < ActiveRecord::Migration
  def change
    remove_index :game_stats, column: [:user_word_id, :game_id]
  end
end
