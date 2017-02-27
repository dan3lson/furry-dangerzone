class ChangeColumnDefaultNumPlayedJeopsGameStats < ActiveRecord::Migration
  def change
    change_column_default :game_stats, :num_played, nil
    change_column_default :game_stats, :num_jeop_won, nil
    change_column_default :game_stats, :num_jeop_lost, nil
  end
end
