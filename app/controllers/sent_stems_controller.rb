class SentStemsController < ApplicationController
  def index
    render json: Word.find(params[:word_id]).sent_stems
  end
end
