class ExampleNonExamplesController < ApplicationController
  def index
    render json: Word.find(params[:word_id]).example_non_examples
  end
end
