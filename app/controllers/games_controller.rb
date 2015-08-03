class GamesController < ApplicationController
  before_action :word

  def fundamentals
    @synonyms = @word.synonyms if @word.synonyms.any?
  end

  private

  def word
    @word = Word.find(params[:word])
  end
end
