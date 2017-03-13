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

    @meaning_alt_count = @word.meaning_alts.count

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
    @word = @m_a.word
    @saved = false

    if @m_a.update(meaning_alt_params)
      @saved = true
    else
      @saved = false
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @m_a = MeaningAlt.find(params[:id])
    @saved = false

    if @m_a.destroy
      @meaning_alts_count = MeaningAlt.count
      @destroyed = true
    else
      @destroyed = false
    end

    respond_to do |format|
      format.js
    end
  end

  def fourth_grade
    @meaning_alt = MeaningAlt.new
    @fourth_grade_words = Word.fourth_grade_grouped
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
