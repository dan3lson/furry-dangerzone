class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :number, null: false
      t.text :description, null: false
      t.timestamps null: false
    end
  end
end
