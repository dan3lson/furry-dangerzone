class RemoveColumnGoalUsers < ActiveRecord::Migration
  def change
    remove_column :users, :goal, :integer, default: 0
  end
end
