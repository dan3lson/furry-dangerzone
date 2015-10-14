class JeopardyGamesController < ApplicationController
  def create
    @word = if Rails.env.test?
      Word.find(params[:word_id].gsub("=",""))
    else
      Word.find(params[:word_id])
    end
    @user_word = UserWord.find_by(user: current_user, word: @word)

    GameLevel.create_jeopardys_for(@user_word)

    if @user_word.user_word_game_levels.count == 28
      msg = "Jeop GLs created: UW #{@user_word.id} -> #{@user_word.word.name}."
      render json: {
        errors: msg
      }
    else
      msg = "Jeop GLs NOT created: UW #{@user_word.id} -> "
      msg_2 = "#{@user_word.word.name}."
      render json: {
        errors: msg << msg_2
      }
    end
  end

  def update
    @word = if Rails.env.test?
              Word.find(params[:word_id].gsub("=", ""))
            else
              Word.find(params[:word_id])
            end
    @user_word = UserWord.find_by(user: current_user, word: @word)

    if @user_word.freestyle_completed?
      msg = "Jeopardy updates not needed for UW #{@user_word.id} ->"
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
        render json: { errors: "Jeopardy successfully updated as complete for UW #{@user_word.id} -> #{@user_word.word.name}" }
      else
        render json: { errors: "Jeopardy NOT successfully updated as complete for UW #{@user_word.id} -> #{@user_word.word.name}" }
      end
    end
  end

  def destroy
    @word = if Rails.env.test?
              Word.find(params[:word_id].gsub("=", ""))
            else
              Word.find(params[:word_id])
            end
    @user_word = UserWord.find_by(user: current_user, word: @word)

    if @user_word.freestyle_completed?
      render json: {
        errors: "Jeopardy GLs untouched for UW #{@user_word.id} -> #{@user_word.word.name}."
      }
    else
      UserWord.destroy_jeopardys_for(@user_word)

      if @user_word.user_word_game_levels.count == 8
        render json: {
          errors: "Jeopardy GLs successfully destroyed for UW #{@user_word.id} -> #{@user_word.word.name}."
        }
      else
        msg = "Jeopardy GLs NOT successfully destroyed for UW #{@user_word.id} ->"
        msg_2 = " #{@user_word.word.name}."
        render json: {
          errors: msg << msg_2
        }
      end
    end
  end
end
