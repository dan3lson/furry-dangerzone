class AddGoalUsers < ActiveRecord::Migration
  def change
    add_column :users, :goal, :integer, default: 0
  end
end
