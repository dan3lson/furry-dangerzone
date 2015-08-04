class GamesController < ApplicationController
  before_action :word

  def fundamentals
    @synonyms = @word.synonyms if @word.has_synonyms?
    @antonyms = @word.antonyms if @word.has_antonyms?
  end

  private

  def word
    @word = Word.find(params[:word])
  end
end
