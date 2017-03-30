class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :user_id, null: false, index: true
      t.integer :classroom_id, null: false, index: true
      t.timestamps null: false
    end
  end
end
