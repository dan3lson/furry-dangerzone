class AddColumnResultToGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :result, :boolean
  end
end
