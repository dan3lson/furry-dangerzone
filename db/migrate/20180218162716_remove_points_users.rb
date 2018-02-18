class RemovePointsUsers < ActiveRecord::Migration
  def change
    remove_column :users, :points, :integer, default: 0, null: false
  end
end
