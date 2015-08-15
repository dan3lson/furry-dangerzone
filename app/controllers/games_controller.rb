class GamesController < ApplicationController
  before_action :word

  def fundamentals
    @synonyms = @word.synonyms if @word.has_synonyms?
    @antonyms = @word.antonyms if @word.has_antonyms?
    @real_world_examples = RealWorldExample.provide(@word.name)
  end

  def jeopardy
  end

  private

  def word
    @word = Word.find(params[:word_id])
  end
end
