class Games::WordRelationshipsController < ApplicationController
  def index
    @target_word = Word.find(params[:word_id])
    @other_incomplete_frees = current_user.incomplete_frees_not(@target_word)
    @second_word = if @other_incomplete_frees.count > 1
                      @other_incomplete_frees.sample
                    else
                      Word.random(1).first
                    end
    render json: @second_word
  end
end
