class School::WordsController < BaseSchoolController
  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    @word.creator_id = current_user.id

    if @word.is_duplicate?
      msg = [
        "Hey #{current_user.username}, that word and defintion already ",
        "exists. Change the name and/or definition and then try again."
      ].join
      flash.now[:warning] = msg
      render :new
    elsif @word.save
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
      :definition,
      :phonetic_spelling,
      :part_of_speech,
      :name,
      :photo,
      :creator_id
    )
  end
end
