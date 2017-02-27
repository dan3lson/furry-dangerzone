class AddColumnNumTypedGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :num_typed, :integer
  end
end
