class RemoveUniquenessNameWords < ActiveRecord::Migration
  def up
    remove_index :words, :name
  end

  def down
    add_index :words, :name, unique: true
  end
end
