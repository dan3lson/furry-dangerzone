class School::ExampleNonExamplesController < BaseSchoolController
  def new
    @e_non_e = ExampleNonExample.new
  end

  def create
    @e_non_e = ExampleNonExample.new(example_non_example_params)
    @word = Word.find(params[:word_id])
    @e_non_e.user = current_user
    @e_non_e.word = @word
    # TODO Refactor - look at FreestylesController for example
    @created = false

    if @e_non_e.save
      @created = true
    else
      @created = false
      @errors = @e_non_e.errors.full_messages
    end

    @e_non_e_count = @word.example_non_examples.count

    respond_to do |format|
      format.js
    end
  end

  def edit
    @e_non_e = ExampleNonExample.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @e_non_e = ExampleNonExample.find(params[:id])
    @updated = false

    if @e_non_e.update(example_non_example_params)
      @updated = true
    else
      @updated = false
    end

    respond_to do |format|
      format.js
    end
  end

  def fourth_grade
    @e_non_e = ExampleNonExample.new
    @fourth_grade_words = Word.fourth_grade
  end

  private

  def example_non_example_params
    params.require(:example_non_example).permit(
      :text,
      :answer,
      :feedback
    )
  end
end
