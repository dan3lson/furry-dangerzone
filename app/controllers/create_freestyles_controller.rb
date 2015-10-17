class CreateFreestylesController < ApplicationController
  def create
    @word_params = Word.find(params[:word_id])
    @word = Rails.env.test? ? @word_params.gsub("=", "") : @word_params
    @user_word = UserWord.find_by(user: current_user, word: @word)

    if @user_word.jeopardy_completed? || @user_word.freestyle_completed?
      msg = "Okay: Freestyle UWGL creations not needed for "
      msg_2 = "UW #{@user_word.id} -> #{@user_word.word.name}."

      render json: { errors: msg << msg_2 }
    else
      GameLevel.create_freestyles_for(@user_word)

      if @user_word.user_word_game_levels.count == 40
        msg = "Success: Freestyle GLs created for UW #{@user_word.id} "
        msg_2 = "-> #{@user_word.word.name}."

        render json: { errors: msg << msg_2 }
      else
        msg = "ERROR: Freestyle GLs not successfully created for "
        msg_2 = "UW #{@user_word.id} -> #{@user_word.word.name}."

        render json: { errors: msg << msg_2 }
      end
    end
  end
end
