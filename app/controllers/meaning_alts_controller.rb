class MeaningAltsController < ApplicationController
  def index
    render json: Word.find(params[:word_id]).meaning_alts
  end
end
