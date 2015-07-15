class UpdateWords < ActiveRecord::Migration
  def change
    rename_column :words, :pronunciation, :phonetic_spelling
    add_column :words, :example_sentence, :string, null: false
  end
end
