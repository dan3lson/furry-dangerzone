class CreateFreestyleDescMes < ActiveRecord::Migration
  def change
    create_table :freestyle_desc_mes do |t|
      t.integer :freestyle_id, null: false, index: true
      t.integer :describe_me_id, null: false, index: true
      t.timestamps null: false
    end
  end
end
