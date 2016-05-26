class JeopardyGamesController < ApplicationController
  def update
    @word_params = Word.find(params[:word_id])
    @word = Rails.env.test? ? @word_params.gsub("=", "") : @word_params
    @user_word = UserWord.object(current_user, @word)

    if @user_word
      if @user_word.jeopardy_completed?
        msg = "Okay: Jeopardy updates not needed for UW #{@user_word.id} ->"
        msg_2 = " #{@user_word.word.name}"

        render json: { errors: msg << msg_2 }
      else
        @user_word.games_completed = 2

        if @user_word.save
          msg = "Success: Jeopardy updated as complete for UW"
          msg_2 = " #{@user_word.id} -> #{@user_word.word.name}"

          render json: { errors: msg << msg_2 }
        else
          msg = "ERROR: Jeopardy NOT successfully updated as complete for"
          msg_2 = " UW #{@user_word.id} -> #{@user_word.word.name}"

          render json: { errors: msg << msg_2 }
        end
      end
    else
      render json: { errors: "Update not needed for random word." }
    end
  end

  def destroy
    @word_params = Word.find(params[:word_id])
    @word = Rails.env.test? ? @word_params.gsub("=", "") : @word_params
    @user_word = UserWord.object(current_user, @word)

    if @user_word
      if @user_word.jeopardy_completed? || @user_word.freestyle_completed?
        msg = "Okay: UW #{@user_word.id}\'s Fundamentals untouched for "
        msg_2 = "UW #{@user_word.id} -> #{@user_word.word.name}."

        render json: { errors: msg << msg_2 }
      else
        @user_word.games_completed = 0

        if @user_word.save
          msg = "Success: UW #{@user_word.id}\'s games_completed reset to 0."

          render json: { errors: msg }
        else
          msg = "ERROR: UW #{@user_word.id}\'s games_completed not reset to 0."

          render json: { errors: msg }
        end
      end
    else
      render json: { errors: "Word is random. Deletion not necessary."}
    end
  end
end
