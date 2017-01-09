class DropTableFeedbacks < ActiveRecord::Migration
  def up
    drop_table :feedbacks
  end

  def down
    create_table :feedbacks do |t|
      t.text :description, null: false
      t.string :kind, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
