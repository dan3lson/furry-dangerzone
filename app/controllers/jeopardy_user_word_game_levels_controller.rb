class JeopardyUserWordGameLevelsController < ApplicationController
  def update
    @word = if Rails.env.test?
      Word.find(params[:word_id].gsub("=", ""))
    else
      Word.find(params[:word_id])
    end

    @user_word = UserWord.find_by(user: current_user, word: @word)


    @user_word.uwgl_jeopardys.each do |uwgl|
      uwgl.status = "complete"
      uwgl.save
    end

    @status = @user_word.uwgl_jeopardys.map { |uwgl|
      uwgl.status
    }.uniq

    if @status.first == "complete"
      render json: { status: "20 UWGLs updated successfully" }
    else
      render json: { status: "20 UWGLs not updated successfully" }
    end
  end
end
