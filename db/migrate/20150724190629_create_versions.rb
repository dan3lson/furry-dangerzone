class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.decimal :number, precision: 4, scale: 2, null: false
      t.timestamps null: false
    end
  end
end
