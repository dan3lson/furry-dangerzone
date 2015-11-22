class School::SchoolsController < BaseSchoolController
  def home
  end

  def classes
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

  def students
    @class = params[:filter]
    @class_name = @class == "fs_class_one" ? "Class One" : "Class Two"
    @fs_class = User.send(@class)
  end

  def student
    @student = User.find(params[:id])

    @words_added_last_day = @student.words_added_last_day
    @funds_completed_last_day = @student.fundamentals_completed_yesterday
    @jeops_completed_last_day = @student.jeopardys_completed_yesterday
    @frees_completed_last_day = @student.freestyles_completed_yesterday
  end

  def messages
    @fs_students = User.fs_class_one + User.fs_class_two
    @user_words = UserWord.select { |uw| uw if uw.freestyle_completed? &&
      uw.user.is_student?
    }
    @responses = FreestyleResponse.includes(:user_word).select { |fr|
      @fs_students.include?(fr.user_word.user)
    }
    @sliced_responses = @responses.each_slice(3)
    @freestyle_types = [
      "Sentence Examples", "Definition Map", "Word Map", "Semantic Map"
    ] * @responses.length
  end

  def progress
  end

  def menu
    @review = Review.new
    @feedback = Feedback.new
  end
end
