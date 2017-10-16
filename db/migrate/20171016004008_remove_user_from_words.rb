class RemoveUserFromWords < ActiveRecord::Migration
  def change
    remove_column :words, :user_id, :integer
  end
end
