class Games::DescribeMesController < ApplicationController
  def index
    @describe_me = Word.find(params[:word_id]).describe_mes.sample
    render json: @describe_me
  end
end
