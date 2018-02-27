class UserWordsController < ApplicationController
  def create
    @word = Word.find(params[:word_id])
    @user_word = UserWord.new(user: current_user, word: @word)

    if @user_word.save
      @created = true

      respond_to do |format|
        format.js
      end
    else
      msg = "Saving that word didn\'t work. Please try again."
      flash[:danger] = msg
      redirect_to dictionary_path
    end
  end

  def destroy
    @user_word = UserWord.find(params[:id])
    @word = @user_word.word

    if @user_word.destroy
      flash[:success] = "Success: \'#{@word.name}\' has been removed."
      redirect_to notebook_path
    else
      msg = "Yikes! Removing that word didn\'t work - please try again."
      flash[:danger] = msg
      redirect_to notebook_path
    end
  end
end
