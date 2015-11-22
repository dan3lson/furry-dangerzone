class AddColumnLoginHistoryUsers < ActiveRecord::Migration
  def change
    add_column :users, :login_history, :string
  end
end
