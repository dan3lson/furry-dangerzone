class School::WordsController < BaseSchoolController
  before_action :logged_in_user
  before_action :correct_user, only: [:new, :create, :edit, :update]

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)

    if @word.save
      flash[:success] = "Success! You created \'#{@word.name}\'."

      redirect_to new_school_word_path
    else
      flash.now[:danger] = "Yikes! Something went wrong. Please try again."

      render :new
    end
  end

  private

  def word_params
    params.require(:word).permit(:name, :phonetic_spelling, :part_of_speech,
      :definition, :example_sentence
    )
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."

      redirect_to login_url
    end
  end

  def correct_user
    unless current_user.can_create_words?
      flash[:danger] = "Yikes! That\'s not something you can do."

      redirect_to menu_path
    end
  end

end
