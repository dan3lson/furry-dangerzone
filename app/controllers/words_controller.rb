class WordsController < ApplicationController
  def index
    @words = current_user.words
  end
end
