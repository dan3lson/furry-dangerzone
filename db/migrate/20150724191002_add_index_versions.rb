class AddIndexVersions < ActiveRecord::Migration
  def change
    add_index :versions, :number, unique: true
  end
end
