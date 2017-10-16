class CreateWordCreators < ActiveRecord::Migration
  def change
    create_table :word_creators do |t|
      t.integer :word_id, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
    add_index :word_creators, :word_id
    add_index :word_creators, :user_id
  end
end
