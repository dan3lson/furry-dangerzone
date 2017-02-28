class AddColumnTypeToGameStat < ActiveRecord::Migration
  def change
    add_column :game_stats, :type, :string
  end
end
