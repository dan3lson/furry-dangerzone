class GamesController < ApplicationController
  def fundamentals
    @word = Word.find(params[:word_id])
    @synonyms = @word.synonyms if @word.has_synonyms?
    @antonyms = @word.antonyms if @word.has_antonyms?
    @real_world_examples = RealWorldExample.provide(@word.name)

    if current_user.has_words? && current_user.has_incomplete_fundamentals?
      @rand_word_id = current_user.incomplete_fundamentals.sample.word.id
    end
  end

  def jeopardy
    @word = Word.find(params[:word_id])
    @second_word = Word.all.sample
    @third_word = Word.all.sample
    @fourth_word = Word.all.sample
  end
end
