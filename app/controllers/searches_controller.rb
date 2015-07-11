class SearchesController < ApplicationController
  def new
    @random_word_placeholder = "e.g. #{Word.all.sample.name}"
    @query = params[:search]
    if @query
      @search_results = Word.search(@query)
    end
  end
end
