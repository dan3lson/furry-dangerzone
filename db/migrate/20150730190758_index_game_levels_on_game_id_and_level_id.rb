class IndexGameLevelsOnGameIdAndLevelId < ActiveRecord::Migration
  def change
    add_index :game_levels, :game_id
    add_index :game_levels, :level_id
    add_index :game_levels, [:game_id, :level_id]
  end
end
