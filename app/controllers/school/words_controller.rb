class School::WordsController < BaseSchoolController
  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)

    if @word.save
      flash[:success] = "Success! You created \'#{@word.name}\'."
      redirect_to new_school_word_path
    else
      render :new
    end
  end

  def student_words
    @classrooms = current_user.classrooms

    respond_to do |format|
      format.html
      format.json { render json: { student_usernames: @student_usernames } }
    end
  end

  private

  def word_params
    params.require(:word).permit(
      :name,
      :phonetic_spelling,
      :part_of_speech,
      :definition
    )
  end
end
