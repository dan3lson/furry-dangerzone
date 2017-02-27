class ChangeColumnNullTimeSpentGameStats < ActiveRecord::Migration
  def change
    change_column_null :game_stats, :time_spent, null: true
  end
end
