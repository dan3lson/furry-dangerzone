class AddColumnStreakUsers < ActiveRecord::Migration
  def change
    add_column :users, :streak, :integer, default: 0, null: false
  end
end
