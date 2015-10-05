class SearchesController < ApplicationController
  def new
    if Word.has_records?
      @random_word_placeholder = "e.g. #{Word.random}"
    end

    @query = params[:search]

    if @query
      @search_results =
        if @query.blank?
          Word.define(@random_word_placeholder.split(" ")[1])
        else
          Word.define(@query)
      end
    end
  end
end
