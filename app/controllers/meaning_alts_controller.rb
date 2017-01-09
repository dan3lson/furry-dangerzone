class MeaningAltsController < ApplicationController
  def index
    @word_meaning_alts = Word.find(params[:word_id]).meaning_alts
    render json: @word_meaning_alts
  end
end
