class UserWordsController < ApplicationController
  def create
    @word = Word.find_by(name: params[:word_to_be_added])
    @user_word = UserWord.new(
      user: current_user,
      word: @word
    )
    if @user_word.save
      flash[:success] = "Awesome - you added \'#{@word.name}\'!"
      redirect_to myLeksi_path
    else
      flash[:danger] = "Yikes! - adding that word didn\'t work. Please try again."
      redirect_to search_path
    end
  end

  def destroy
    @user_word = UserWord.find(params[:id])
    @word = Word.find_by(name: params[:word_name])
    if @user_word.destroy
      flash[:success] = "\'#{@word.name}\' has been removed."
      redirect_to myLeksi_path
    else
      msg = "Yikes! - removing a word didn\'t work! Please try again."
      flash[:danger] = msg
      redirect_to words_path
    end
  end
end
