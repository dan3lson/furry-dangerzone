class WordsController < ApplicationController
  def index
    @words = Word.all
  end

  def show
    @word = Word.find(params[:id])
    @current_user_sources = current_user.sources
    @untagged_source = Source.find(1)
  end
end
