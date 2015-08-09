class GamesController < ApplicationController
  before_action :word

  def fundamentals
    @synonyms = @word.synonyms if @word.has_synonyms?
    @antonyms = @word.antonyms if @word.has_antonyms?
    @real_world_examples = RealWorldExample.provide(@word.name)

    if false
      @user_word = UserWord.find_by(user: current_user, word: @word)
      
    end
  end

  private

  def word
    @word = Word.find(params[:word])
  end
end
