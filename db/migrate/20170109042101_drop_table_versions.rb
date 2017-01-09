class DropTableVersions < ActiveRecord::Migration
  def up
    drop_table :versions
  end

  def down
    create_table :versions do |t|
      t.string :number, null: false
      t.text :description, null: false
      t.timestamps null: false
    end
  end
end
