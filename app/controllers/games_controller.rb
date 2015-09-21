class GamesController < ApplicationController
  before_action :chosen_word

  def fundamentals
    @synonyms = chosen_word.synonyms if chosen_word.has_synonyms?
    @antonyms = chosen_word.antonyms if chosen_word.has_antonyms?
    @real_world_examples = RealWorldExample.provide(chosen_word.name)

    if current_user.has_words? && current_user.has_incomplete_fundamentals?
      @rand_word_id = current_user.incomplete_fundamentals.sample.word.id
    end
  end

  def jeopardy
  end

  def jeopardy_game_words
    @second_word = Word.all.sample
    @third_word = Word.all.sample
    @fourth_word = Word.all.sample
    @jeopardy_words = [chosen_word, @second_word, @third_word, @fourth_word]

    render json: @jeopardy_words
  end

  private

  def chosen_word
    @chosen_word = Word.find(params[:word_id])
  end
end
