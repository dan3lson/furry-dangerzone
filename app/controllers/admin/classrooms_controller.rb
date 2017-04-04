class Admin::ClassroomsController < BaseAdminController
  def index
    @classrooms = Classroom.page(params[:page])
    @classrooms_count = @classrooms.count
  end

  def show
    @classroom = Classroom.find(params[:id])
  end
end
