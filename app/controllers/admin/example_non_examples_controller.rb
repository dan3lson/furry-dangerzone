class Admin::ExampleNonExamplesController < BaseAdminController
  def index
    @filter = params[:filter]
		@ex_non_ex_count = ExampleNonExample.count

    if @filter
      if @filter == "latest"
        @ex_non_exs = ExampleNonExample.order("created_at DESC")
      																 .page(params[:page])
      end
    else
      @ex_non_exs = ExampleNonExample.page(params[:page])
    end
  end

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
