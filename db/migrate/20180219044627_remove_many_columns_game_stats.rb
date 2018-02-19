class RemoveManyColumnsGameStats < ActiveRecord::Migration
  def change
    remove_column :game_stats, :num_played, :integer
    remove_column :game_stats, :num_jeop_won, :integer
    remove_column :game_stats, :num_jeop_lost, :integer
    remove_column :game_stats, :num_typed, :integer
    remove_column :game_stats, :num_bad_clicks, :integer
    remove_column :game_stats, :num_heard, :integer
    remove_column :game_stats, :result, :boolean
    remove_column :game_stats, :category, :string
    remove_column :game_stats, :word_name, :string
    remove_column :game_stats, :linero, :integer
  end
end
