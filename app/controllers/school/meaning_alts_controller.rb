class School::MeaningAltsController < BaseSchoolController
  def new
    @m_a = MeaningAlt.new
  end

  def create
    @m_a = MeaningAlt.new(meaning_alt_params)
    @word = Word.find(params[:word_id])
    @m_a.word = @word
    @m_a.creator = current_user
    @created = false

    if @m_a.save
      @created = true
    else
      @created = false
    end

    respond_to do |format|
      format.js
    end
  end

  def edit
    @m_a = MeaningAlt.find(params[:id])
    @word = @m_a.word

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @m_a = MeaningAlt.find(params[:id])
    @updated = @m_a.update(meaning_alt_params)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @m_a = MeaningAlt.find(params[:id])
    @destroyed = @m_a.destroy ? true : false

    respond_to do |format|
      format.js
    end
  end

  def fourth_grade
    @meaning_alt = MeaningAlt.new
    @fourth_grade_words = Word.fourth_grade
  end

  private

  def meaning_alt_params
    params.require(:meaning_alt).permit(
      :text,
      :choices,
      :answer,
      :feedback
    )
  end
end
