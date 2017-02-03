class Games::WordRelationshipsController < ApplicationController
  def index
    @target_word = Word.find(params[:word_id])
    @second_word = current_user.incomplete_frees_not(@target_word).sample
    render json: @second_word
  end
end
