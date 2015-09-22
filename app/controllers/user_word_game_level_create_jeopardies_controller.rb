class UserWordGameLevelCreateJeopardiesController < ApplicationController
  def create
    @word = if Rails.env.test?
      Word.find(params[:word_id].gsub("=",""))
    else
      Word.find(params[:word_id])
    end
    @user_word = UserWord.find_by(user: current_user, word: @word)

    GameLevel.create_jeopardys_for(@user_word)

    if @user_word.user_word_game_levels.count == 28
      render json: {
        status: "Jeopardy GLs successfully created for UW #{@user_word.id}."
      }
    else
      render json: {
        status: "Jeopardy GLs not successfully created for UW #{@user_word.id}."
      }
    end
  end
end
