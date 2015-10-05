class TeachersController < ApplicationController
  def classrooms
    @fs_class_one = User.fs_class_one
    @fs_class_two = User.fs_class_two
    @fs_students = @fs_class_one + @fs_class_two
  end
end
