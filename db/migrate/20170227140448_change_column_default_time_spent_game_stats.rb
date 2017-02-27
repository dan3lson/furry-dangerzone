class ChangeColumnDefaultTimeSpentGameStats < ActiveRecord::Migration
  def change
    change_column_default :game_stats, :time_spent, nil
  end
end
