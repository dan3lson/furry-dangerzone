class School::SchoolsController < BaseSchoolController
  def home
  end

  def classes
  end

  def words
    @class = params[:filter]
    @class_name = @class == "fs_class_one" ? "Class One" : "Class Two"
    @fs_class = User.send(@class)
    @fs_class_words = @fs_class.map { |stu| stu.words }.flatten.uniq!.sort_by { |w|
      w.name
    }
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
