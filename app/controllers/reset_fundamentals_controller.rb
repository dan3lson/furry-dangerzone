class ResetFundamentalsController < ApplicationController
  def update
    @word = if Rails.env.test?
      Word.find(params[:word_id].gsub("=", ""))
    else
      Word.find(params[:word_id])
    end

    @user_word = UserWord.find_by(user: current_user, word: @word)

    @user_word.uwgl_fundamentals.each do |uwgl|
      uwgl.status = "not started"
      uwgl.save
    end

    @status = @user_word.uwgl_fundamentals.map { |uwgl|
      uwgl.status
    }.uniq

    if @status.first == "not started"
      render json: {
        errors: "UW #{@user_word.id}\'s Fundamentals successfully reset"
      }
    else
      render json: {
        errors: "UW #{@user_word.id}\'s Fundamentals NOT successfully reset"
      }
    end
  end
end
