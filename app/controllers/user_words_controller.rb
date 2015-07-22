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
    @word_sources = current_user.word_sources.where(word: @word)
    @word_sources.each do |word_source|
      if word_source.user_word_sources.count == 1
        @user_word_source = word_source.user_word_sources.first
        word_source.destroy
        @user_word_source.destroy
      else
        # not totally working
        @user_word_source = UserWordSource.find_by(
          user: current_user,
          word_source: word_source
        )
        @user_word_source.destroy
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
