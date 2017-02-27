class AddColumnTimeStartedGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :time_started, :datetime
  end
end
