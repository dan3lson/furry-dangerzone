class AddIndexNameDefinitionWords < ActiveRecord::Migration
  def change
    add_index :words, :name
    add_index :words, [:name, :definition]
  end
end
