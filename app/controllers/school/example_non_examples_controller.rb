class School::ExampleNonExamplesController < BaseSchoolController
  def new
    @e_non_e = ExampleNonExample.new
  end

  def create
    @e_non_e = ExampleNonExample.new(example_non_example_params)
    @word = Word.find(params[:word_id])
    @created = false

    if @e_non_e.save
      @e_non_e.words << @word
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

  def seventh_grade
    @e_non_e = ExampleNonExample.new
    @example_non_examples = Word.pilot_for_seventh_grade
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
