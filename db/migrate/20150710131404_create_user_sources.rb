class CreateUserSources < ActiveRecord::Migration
  def change
    create_table :user_sources do |t|
      t.integer :user_id, null: false
      t.integer :source_id, null: false
      t.timestamps null: false
    end
  end
end
