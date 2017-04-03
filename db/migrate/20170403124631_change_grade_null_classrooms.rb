class ChangeGradeNullClassrooms < ActiveRecord::Migration
  def change
    change_column_null :classrooms, :grade, false
  end
end
