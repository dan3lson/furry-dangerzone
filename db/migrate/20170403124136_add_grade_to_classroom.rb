class AddGradeToClassroom < ActiveRecord::Migration
  def change
    add_column :classrooms, :grade, :integer
  end
end
