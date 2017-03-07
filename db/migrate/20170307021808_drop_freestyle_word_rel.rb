class DropFreestyleWordRel < ActiveRecord::Migration
  def change
    drop_table :freestyle_word_rels
  end
end
