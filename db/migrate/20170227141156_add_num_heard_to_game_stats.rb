class AddNumHeardToGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :num_heard, :integer
  end
end
