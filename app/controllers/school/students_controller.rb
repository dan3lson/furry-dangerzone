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
    @usernames = params[:username].split(",").map(&:strip).reject(&:empty?)
    @msgs = { successes: [], errors: [] }

    @usernames.each do |username|
      @student = @classroom.students.new(
        username: username,
        password: "leksi#{Date.today.year}",
        password_confirmation: "leksi#{Date.today.year}"
      )
      @student.teacher = current_user

      if @student.save
        @msgs[:successes] << @student
      else
        @msgs[:errors] << @student
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def show
    @student = User.find(params[:id])
  end

  def add_words
    @classrooms = current_user.classrooms.alphabetical
    @students = current_user.classrooms
                            .includes(:students)
                            .map(&:students)
                            .flatten
                            .map(&:username)
                            .flatten
                            .sort
    @tag = Tag.new
  end
end
