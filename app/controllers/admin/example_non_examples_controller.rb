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

  private

  def example_non_example_params
    params.require(:example_non_example).permit(
      :text,
      :answer,
      :feedback
    )
  end
end
