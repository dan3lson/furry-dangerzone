class School::MeaningAltsController < BaseSchoolController
  def new
    @m_a = MeaningAlt.new
  end

  def create
    @m_a = MeaningAlt.new(meaning_alt_params)
    @word = Word.find(params[:word_id])
    @m_a.word = @word
    @m_a.user = current_user
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

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @m_a = MeaningAlt.find(params[:id])
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

  def seventh_grade
    @seventh_grade_grouped_words = Word.seventh_grade_grouped
    @meaning_alt = MeaningAlt.new
  end

  def eigth_grade
    @seventh_grade_words = Word.eighth_grade
    @meaning_alt = MeaningAlt.new
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
