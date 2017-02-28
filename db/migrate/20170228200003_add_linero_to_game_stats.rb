class AddLineroToGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :linero, :integer
  end
end
