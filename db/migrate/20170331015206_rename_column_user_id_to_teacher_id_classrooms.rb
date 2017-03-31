class RenameColumnUserIdToTeacherIdClassrooms < ActiveRecord::Migration
  def change
    rename_column :classrooms, :user_id, :teacher_id
  end
end
