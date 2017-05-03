class JeopardyGamesController < ApplicationController
  def update
    @word = Word.find(params[:word_id])
    @user_word = UserWord.object(current_user, @word)

    if @user_word      
      if @user_word.jeopardy_completed?
        msg = [
          "Okay: Jeopardy updates not needed for UW #{@user_word.id} ->",
          " #{@user_word.word.name}"
        ].join
        render json: { response: msg }
      else
        if @word.has_sent_stems?
          @user_word.games_completed = 8
        else
          @user_word.games_completed = 9
        end

        if @user_word.save
          msg = [
            "Success: UW #{@user_word.id}/#{@user_word.word.name} ",
            "games_completed now at #{@user_word.games_completed} "
          ].join
          render json: { response: msg }
        else
          msg = [
            "ERROR: Jeopardy NOT successfully updated as complete for" ,
            "UW #{@user_word.id}/#{@user_word.word.name}"
          ].join
          render json: { errors: msg }
        end
      end
    else
      render json: { response: "Okay: word is random. Update not needed." }
    end
  end

  def destroy
    @word = Word.find(params[:word_id])
    @user_word = UserWord.object(current_user, @word)

    if @user_word
      if @user_word.jeopardy_completed? || @user_word.all_freestyles_completed?
        msg = "Okay: UW #{@user_word.id}\'s Fundamentals untouched for "
        msg_2 = "UW #{@user_word.id} -> #{@user_word.word.name}."
        render json: { response: msg << msg_2 }
      else
        @user_word.games_completed = 0

        if @user_word.save
          msg = "Success: UW #{@user_word.id}\'s games_completed reset to 0."
          render json: { response: msg }
        else
          msg = "ERROR: UW #{@user_word.id}\'s games_completed not reset to 0."
          render json: { errors: msg }
        end
      end
    else
      render json: { response: "Okay: word is random. Demotion not needed."}
    end
  end
end
