class CreateDescribeMes < ActiveRecord::Migration
  def change
    create_table :describe_mes do |t|
      t.string :text, null: false
      t.integer :word_id, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
