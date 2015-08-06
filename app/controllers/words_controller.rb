class WordsController < ApplicationController
  def index
    @words = Word.all
  end

  def show
    @word = Word.find(params[:id])
    @user_word = UserWord.find_by(user: current_user, word: @word)
  end
end
