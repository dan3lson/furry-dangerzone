class GamesController < ApplicationController
  before_action :word

  def fundamentals
  end

  private

  def word
    @word = Word.find(params[:word])
  end
end
