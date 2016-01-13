class AssessmentsController < ApplicationController
  def knowledge_scale
  end

  def search_results
    word = params[:search]

    @results = UserWord.search(current_user, word)

    respond_to do |format|
      format.js
    end
  end
end
