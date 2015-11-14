class AddColumnTimeSpentGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :time_spent, :decimal, precision: 5, scale: 2,
      null: false, default: 0.00
  end
end
