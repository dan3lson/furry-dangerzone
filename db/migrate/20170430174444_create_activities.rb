class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :action, null: false, index: true
      t.integer :user_id, null: false, index: true
      t.integer :trackable_id, null: false, index: true
      t.string :trackable_type, null: false, index: true
      t.timestamps null: false
    end
  end
end
