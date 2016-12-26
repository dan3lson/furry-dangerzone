class WordsController < ApplicationController
  def index
    @words = Word.all
  end

  def show
    @word = Word.find(params[:id])
  end

  def seventh_grade
    @seventh_grade_words = Word.seventh_grade
    @meaning_alt = MeaningAlt.new
  end

  def eigth_grade
    @seventh_grade_words = Word.eighth_grade
    @meaning_alt = MeaningAlt.new
  end
end
