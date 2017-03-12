class CreateFreestyleLekTale < ActiveRecord::Migration
  def change
    create_table :freestyle_lek_tales do |t|
      t.integer :freestyle_id, null: false
      t.text :incl_words, null: false
      t.timestamps null: false
    end
  end
end
