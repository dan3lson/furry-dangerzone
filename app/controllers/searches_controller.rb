class SearchesController < ApplicationController
  def new
    @query = params[:search]
    if @query
      @search_results = Word.search(@query)
    end
  end
end
