class CreateUserWords < ActiveRecord::Migration
  def change
    create_table :user_words do |t|
      t.integer :user_id, null:false
      t.integer :word_id, null:false
      t.timestamps null:false
    end
  end
end
