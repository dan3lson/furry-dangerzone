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
        flash[:success] = "Success! You can add students to this classroom now."
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

  def recent_activity
    @student = User.find(params[:id])
    @words_added_last_day = @student.words_added_last_day
    @funds_completed_last_day = @student.fundamentals_completed_yesterday
    @jeops_completed_last_day = @student.jeopardys_completed_yesterday
    @frees_completed_last_day = @student.freestyles_completed_yesterday
  end

  def words
    @class = params[:filter]
    @class_name = @class == "fs_class_one" ? "Class One" : "Class Two"
    @fs_class = User.send(@class)
    @fs_class_words = @fs_class.map { |stu| stu.words }.flatten.sort_by { |w|
      w.name
    }.uniq { |w| w.name }
    @fs_class_words_count = @fs_class_words.count
    @first_word_letter = @fs_class_words.first.name[0].capitalize
  end

  def progress
    @class = params[:filter] ? User.send(params[:filter]) : User.fs_class_one
    @title_and_header = if params[:filter]
      params[:filter] == "fs_class_one" ? "Class One" : "Class Two"
    else
      "Class One"
    end

    @sorted_num_logins = @class.order(:num_logins)
    @lowest_num_logins = @sorted_num_logins.take(5)
    @highest_num_logins = @sorted_num_logins.reverse.take(5)

    @sorted_myLeksi_mastery = @class.sort_by(&:myLeksi_mastery)
    @lowest_myLeksi_mastery = @sorted_myLeksi_mastery.take(5)
    @highest_myLeksi_mastery = @sorted_myLeksi_mastery.reverse.take(5)

    @sorted_words_count = @class.sort_by { |u| u.num_words }
    @least_saved_words = @sorted_words_count.take(5)
    @most_saved_words = @sorted_words_count.reverse.take(5)

    @sorted_time_spent_playing = @class.sort_by { |u| u.time_spent_playing }
    @least_time_spent_playing = @sorted_time_spent_playing.take(5)
    @most_time_spent_playing = @sorted_time_spent_playing.reverse.take(5)

    @sorted_completed_fundamentals = @class.sort_by { |u|
      u.completed_fundamentals.count
    }
    @least_funds_played = @sorted_completed_fundamentals.take(5)
    @most_funds_played = @sorted_completed_fundamentals.reverse.take(5)

    @sorted_completed_jeopardys = @class.sort_by { |u|
      u.completed_jeopardys.count
    }
    @least_jeops_played = @sorted_completed_jeopardys.take(5)
    @most_jeops_played = @sorted_completed_jeopardys.reverse.take(5)

    @sorted_completed_freestyles = @class.sort_by { |u|
      u.completed_freestyles.count
    }
    @least_frees_played = @sorted_completed_freestyles.take(5)
    @most_frees_played = @sorted_completed_freestyles.reverse.take(5)
  end

  private

  def classroom_params
    params.require(:classroom).permit(:name)
  end
end
