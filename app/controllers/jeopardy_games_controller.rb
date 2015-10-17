class JeopardyGamesController < ApplicationController
  def create
    @word_params = Word.find(params[:word_id])
    @word = Rails.env.test? ? @word_params.gsub("=", "") : @word_params
    @user_word = UserWord.find_by(user: current_user, word: @word)

    if @user_word.uwgl_jeopardys.any?
      msg = "Okay: Jeopardy UWGLs already exist and skipped for "
      msg_2 = "UW #{@user_word.id} -> #{@user_word.word.name}."

      render json: { errors: msg << msg_2 }
    else
      GameLevel.create_jeopardys_for(@user_word)

      if @user_word.user_word_game_levels.count == 28
        msg = "Success: Jeopardy UWGLs created for UW #{@user_word.id} "
        msg_2 = "-> #{@user_word.word.name}."

        render json: { errors: msg << msg_2 }
      else
        msg = "ERROR: Jeop GLs NOT created: UW #{@user_word.id} -> "
        msg_2 = "#{@user_word.word.name}."

        render json: { errors: msg << msg_2 }
      end
    end
  end

  def update
    @word_params = Word.find(params[:word_id])
    @word = Rails.env.test? ? @word_params.gsub("=", "") : @word_params
    @user_word = UserWord.find_by(user: current_user, word: @word)

    if @user_word.jeopardy_completed? || @user_word.freestyle_completed?
      msg = "Okay: Jeopardy updates not needed for UW #{@user_word.id} ->"
      msg_2 = " #{@user_word.word.name}"

      render json: { errors: msg << msg_2 }
    else
      @user_word.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      @status = @user_word.uwgl_jeopardys.map { |uwgl|
        uwgl.status
      }.uniq

      if @status.first == "complete"
        msg = "Success: Jeopardy updated as complete for UW"
        msg_2 = " #{@user_word.id} -> #{@user_word.word.name}"

        render json: { errors: msg << msg_2 }
      else
        msg = "ERROR: Jeopardy NOT successfully updated as complete for"
        msg_2 = " UW #{@user_word.id} -> #{@user_word.word.name}"

        render json: { errors: msg << msg_2 }
      end
    end
  end

  def destroy
    @word_params = Word.find(params[:word_id])
    @word = Rails.env.test? ? @word_params.gsub("=", "") : @word_params
    @user_word = UserWord.find_by(user: current_user, word: @word)

    if @user_word.jeopardy_completed? || @user_word.freestyle_completed?
      msg = "Okay: Jeopardy UWGLs destruction not needed for "
      msg_2 = "UW #{@user_word.id} -> #{@user_word.word.name}."

      render json: { errors: msg << msg_2 }
    else
      UserWord.destroy_jeopardys_for(@user_word)

      if @user_word.user_word_game_levels.count == 8
        msg = "Success: Jeopardy GLs destroyed for UW #{@user_word.id}"
        msg_2 = " -> #{@user_word.word.name}."

        render json: { errors: msg << msg_2 }
      else
        msg = "ERROR: Jeopardy GLs NOT successfully destroyed for"
        msg_2 = " UW #{@user_word.id} - #{@user_word.word.name}."

        render json: { errors: msg << msg_2 }
      end
    end
  end
end
