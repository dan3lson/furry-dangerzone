class ResetFundamentalsController < ApplicationController
  # DELETE THIS FILE
  def update
    @word_params = Word.find(params[:word_id])
    @word = Rails.env.test? ? @word_params.gsub("=", "") : @word_params
    @user_word = UserWord.find_by(user: current_user, word: @word)

    if @user_word.jeopardy_completed? || @user_word.freestyle_completed?
      render json: {
        errors: "Okay: UW #{@user_word.id}\'s Fundamentals untouched."
      }
    else
      @user_word.games_completed == 0

      if @user_word.save
        render json: {
          errors: "Success: UW #{@user_word.id}\'s games_completed reset to 0."
        }
      else
        render json: {
          errors: "ERROR: UW #{@user_word.id}\'s games_completed not reset."
        }
      end
    end
  end
end
