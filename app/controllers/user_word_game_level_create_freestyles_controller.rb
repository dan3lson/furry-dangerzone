class UserWordGameLevelCreateFreestylesController < ApplicationController
  def create
    @word = if Rails.env.test?
      Word.find(params[:word_id].gsub("=", ""))
    else
      Word.find(params[:word_id])
    end
    @user_word = UserWord.find_by(user: current_user, word: @word)

    GameLevel.create_freestyles_for(@user_word)

    if @user_word.user_word_game_levels.count == 40
      render json: {
        status: "Freestyle GLs successfully created for UW #{@user_word.id}."
      }
    else
      render json: {
        status: "Freestyle GLs not successfully created for UW #{@user_word.id}."
      }
    end
  end
end
