class SearchesController < ApplicationController
  def new
    @query = params[:search]
    if @query
      @search_results = Word.search(@query).limit(3)
    end
  end
end
