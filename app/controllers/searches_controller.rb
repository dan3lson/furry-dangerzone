class SearchesController < ApplicationController
  def search
    if params[:rand]
      @random_word = Word.random
      @results = Word.define(@random_word)
    else
      @results = Word.define(params[:search]) if params[:search]
    end

    @display_button_for = params[:display_button_for]

    respond_to do |format|
      format.html
      format.js
    end
  end

  def student_words
  end
end
