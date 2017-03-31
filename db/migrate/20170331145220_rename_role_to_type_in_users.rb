class RenameRoleToTypeInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :role, :type
  end
end
