class SearchesController < ApplicationController
  def search
  end

  def search_results
    @results = if params[:rand]
                 Word.define(Word.random)
               else
                 Word.define(params[:search]) if params[:search]
               end

    @display_button_for = params[:display_button_for]

    respond_to do |format|
      format.js
    end
  end

  def student_words
  end
end
