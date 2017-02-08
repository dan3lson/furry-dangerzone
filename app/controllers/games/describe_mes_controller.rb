class Games::DescribeMesController < ApplicationController
  def index
    render json: Word.find(params[:word_id]).describe_mes.sample
  end
end
