class AddIndicesClassrooms < ActiveRecord::Migration
  def change
    add_index :classrooms, :name
    add_index :classrooms, :teacher_id
    add_index :classrooms, [:name, :teacher_id], unique: true
  end
end
