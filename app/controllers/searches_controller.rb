class SearchesController < ApplicationController
  def search
    @random_word = Word.random(1).first
    @seventh_grade_words = Word.pilot_for_seventh_grade.take(5)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def results
    @search = params[:search]

    if @search
      @input_words = @search.split(",").map(&:strip)
      @words = @input_words.map { |w| Word.define(w) }.flatten

      respond_to do |format|
        format.js
      end
    end
  end
end
