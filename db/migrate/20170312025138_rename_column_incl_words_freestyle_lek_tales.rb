class RenameColumnInclWordsFreestyleLekTales < ActiveRecord::Migration
  def change
    rename_column :freestyle_lek_tales, :incl_words, :word_ids
  end
end
