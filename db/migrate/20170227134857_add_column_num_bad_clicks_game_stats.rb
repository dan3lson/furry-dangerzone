class AddColumnNumBadClicksGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :num_bad_clicks, :integer
  end
end
