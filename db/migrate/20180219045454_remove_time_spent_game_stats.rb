class RemoveTimeSpentGameStats < ActiveRecord::Migration
  def change
    remove_column :game_stats, :time_spent, :decimal
  end
end
