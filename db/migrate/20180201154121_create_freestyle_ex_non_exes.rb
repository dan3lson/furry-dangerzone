class CreateFreestyleExNonExes < ActiveRecord::Migration
  def change
    create_table :freestyle_ex_non_exes do |t|
      t.integer :freestyle_id, null: false
      t.string :type, null: false
      t.timestamps null: false
    end

    add_index :freestyle_ex_non_exes, :freestyle_id
  end
end
