class RemoveWordCreators < ActiveRecord::Migration
  def change
    drop_table :word_creators do |t|
      t.integer :word_id, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
