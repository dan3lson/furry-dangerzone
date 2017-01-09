class DropTableReviews < ActiveRecord::Migration
  def up
    drop_table :reviews
  end

  def down
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.text :description
      t.integer :user_id, null: false
      t.integer :version_id, null: false
      t.timestamps null: false
    end
  end
end
