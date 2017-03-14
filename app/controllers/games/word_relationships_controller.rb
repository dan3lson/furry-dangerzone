class Games::WordRelationshipsController < ApplicationController
  def index
    @target_word = Word.find(params[:word_id])
    @second_word = if current_user.incomplete_words.count > 1
      current_user.incomplete_frees_not(@target_word).sample
    else
      Word.random(1).first
    end
    render json: @second_word
  end
end
