class AddColumnRoleUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: "brainiac", null: false
  end
end
