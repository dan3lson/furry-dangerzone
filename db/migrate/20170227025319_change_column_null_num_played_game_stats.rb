class ChangeColumnNullNumPlayedGameStats < ActiveRecord::Migration
  def change
    change_column_null :game_stats, :num_played, null: true
  end
end
