class AddColumnsToGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :num_jeop_won, :integer, default: 0, null: false
    add_column :game_stats, :num_jeop_lost, :integer, default: 0, null: false
  end
end
