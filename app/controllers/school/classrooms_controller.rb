class School::ClassroomsController < BaseSchoolController
  def index
    @classrooms = current_user.classrooms
    @classrooms_count= @classrooms.count
  end

  def new
    @classroom = Classroom.new
  end

  def create
    @classroom = current_user.classrooms.new(classroom_params)

    if current_user.has_classroom?(@classroom)
      msg = [
        "Hey #{current_user.username}, you already have that classroom. ",
        " Change the name and then try creating it again."
      ].join
      flash.now[:warning] = msg
      render :new
    else
      if @classroom.save
        flash[:success] = [
          "Success! You can add students to this classroom now by clicking ",
          "the blue Add Students button below."
        ].join
        redirect_to school_classroom_path(@classroom)
      else
        render :new
      end
    end
  end

  def show
    @classroom = Classroom.find(params[:id])
    @classroom_stu_count = @classroom.students.count
  end

  # def words
  #   @class = params[:filter]
  #   @class_name = @class == "fs_class_one" ? "Class One" : "Class Two"
  #   @fs_class = User.send(@class)
  #   @fs_class_words = @fs_class.map { |stu| stu.words }.flatten.sort_by { |w|
  #     w.name
  #   }.uniq { |w| w.name }
  #   @fs_class_words_count = @fs_class_words.count
  #   @first_word_letter = @fs_class_words.first.name[0].capitalize
  # end

  private

  def classroom_params
    params.require(:classroom).permit(:name, :grade)
  end
end
