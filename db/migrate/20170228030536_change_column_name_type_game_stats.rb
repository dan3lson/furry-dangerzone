class ChangeColumnNameTypeGameStats < ActiveRecord::Migration
  def change
    rename_column :game_stats, :type, :category
  end
end
