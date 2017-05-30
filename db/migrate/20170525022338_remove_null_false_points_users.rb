class RemoveNullFalsePointsUsers < ActiveRecord::Migration
  def change
    change_column_null :users, :points, :integer, null: true
  end
end
