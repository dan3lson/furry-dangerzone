class WordsController < ApplicationController
  def index
    if params[:search]
      @words = Word.search(params[:search])
    elsif params[:filter_by] == "all"
      @words = Word.all
    elsif params[:filter_by] == "myLeksi"
      @words = current_user.words
    else
      @words = Word.all
    end
  end
end
