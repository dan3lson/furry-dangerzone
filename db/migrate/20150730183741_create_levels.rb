class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :focus, null: false
      t.string :direction, null: false
      t.timestamps null: false
    end
  end
end
