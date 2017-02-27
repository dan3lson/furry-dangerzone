class ChangeColumnNullJeopsGameStats < ActiveRecord::Migration
  def change
    change_column_null :game_stats, :num_jeop_won, :integer, null: true
    change_column_null :game_stats, :num_jeop_lost, :integer, null: true
  end
end
