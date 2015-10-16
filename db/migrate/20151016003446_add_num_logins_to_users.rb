class AddNumLoginsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :num_logins, :integer, default: 0, null: false
  end
end
