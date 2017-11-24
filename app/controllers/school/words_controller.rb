class School::WordsController < BaseSchoolController
  def index
    @words = current_user.created_words
  end

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
      @created = true;
      redirect_to school_words_path
      # @e_non_e = ExampleNonExample.new
      # @m_a = MeaningAlt.new
      #
      # respond_to do |format|
      #   format.js
      # end
    else
      @created = false
      render :new
    end
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    @word = Word.find(params[:id])

    if @word.update(word_params)
      flash[:success] = "You successfully updated the word \'#{@word.name}\'."
      redirect_to school_words_path
    else
      render :edit
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
