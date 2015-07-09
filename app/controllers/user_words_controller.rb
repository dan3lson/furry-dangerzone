class UserWordsController < ApplicationController
  def create
    @word_name = params[:word_to_be_added]
    @user_word = UserWord.new(
      user: current_user,
      word: Word.find_by(name: @word_name)
    )
    if @user_word.save
      flash[:success] = "Awesome - you added #{@word_name}!"
      redirect_to words_path
    else
      flash[:success] = "Yikes! - something went wrong! Please try again."
      render :new
    end
  end
end
