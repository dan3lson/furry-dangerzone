class UserWordsController < ApplicationController
  def create
    @word = Word.find_by(name: params[:word_to_be_added])
    @user_word = UserWord.new(
      user: current_user,
      word: @word
    )
    if @user_word.save
      flash[:success] = "Awesome - you added \'#{@word.name}\'!"
      redirect_to @word
    else
      flash[:danger] = "Yikes! - adding that word didn\'t work. Please try again."
      redirect_to search_path
    end
  end

  def destroy
    @user_word = UserWord.find(params[:id])
    @word = @user_word.word
    @word_tags = current_user.word_tags.where(word: @word)
    @word_tags.each do |word_tag|
      if word_tag.user_word_tags.count == 1
        @user_word_tag = word_tag.user_word_tags.first
        word_tag.destroy
        @user_word_tag.destroy
      else
        @user_word_tag = UserWordTag.find_by(
          user: current_user,
          word_tag: word_tag
        )
        @user_word_tag.destroy
      end
    end

    if @user_word.destroy
      flash[:success] = "\'#{@word.name}\' has been removed."
      redirect_to myLeksi_path
    else
      msg = "Yikes! - removing a word didn\'t work! Please try again."
      flash[:danger] = msg
      redirect_to myLeksi_path
    end
  end
end
