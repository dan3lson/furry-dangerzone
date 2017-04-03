class AddIndexUniqNameDefinitionWords < ActiveRecord::Migration
  def change
    remove_index :words, column: [:name, :definition]
    add_index :words, [:name, :definition], unique: true
  end
end
