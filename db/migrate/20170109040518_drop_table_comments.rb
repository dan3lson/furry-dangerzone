class DropTableComments < ActiveRecord::Migration
  def up
    drop_table :comments
  end

  def down
    create_table :comments do |t|
      t.text :description, null: false
      t.integer :blog_post_id, null: false
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
