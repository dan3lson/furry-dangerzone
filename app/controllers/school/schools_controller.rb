class School::SchoolsController < BaseSchoolController
  def home
  end

  def classes
  end

  def students
    @class = params[:filter]
    @fs_class = User.send(@class)
    @class_name = @class == "fs_class_one" ? "Class One" : "Class Two"
  end

  def student
    @student = User.find(params[:id])
  end

  def messages
    @fs_students = User.fs_class_one + User.fs_class_two
    @user_words = UserWord.select { |uw| uw if uw.freestyle_completed? &&
      uw.user.role == "student"
    }
    @responses = FreestyleResponse.includes(:user_word_game_level).select { |f|
      @fs_students.include?(f.user_word_game_level.user_word.user)
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
  end
end
