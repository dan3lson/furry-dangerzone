class School::ExampleNonExamplesController < BaseSchoolController
  def new
    @e_non_e = ExampleNonExample.new
  end

  def create
    @e_non_e = ExampleNonExample.new(example_non_example_params)
    @word = Word.find(params[:word_id])
    @saved = false

    if @e_non_e.save
      @e_non_e.words << @word
      @saved = true
    else
      @saved = false
      @errors = @e_non_e.errors.full_messages
    end

    respond_to do |format|
      format.js
    end
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
