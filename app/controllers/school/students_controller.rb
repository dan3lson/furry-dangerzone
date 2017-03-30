class School::StudentsController < BaseSchoolController
  def index
    @classroom = Classroom.find(params[:classroom_id])
    @students = @classroom.students
  end

  def new
    @classroom = Classroom.find(params[:classroom_id])
  end

  def create
    @classroom = Classroom.find(params[:classroom_id])
    @usernames = params[:username].split(",").map(&:strip)

    @usernames.each do |username|
      @student = @classroom.students.new(teacher: current_user, user: @user)
      binding.pry
      @user = User.new(
        role: "student",
        username: username,
        password: username,
        password_confirmation: username
      )
    end
  end

  def show
    @student = User.find(params[:id])
  end
end
