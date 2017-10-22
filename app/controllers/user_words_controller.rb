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

  # TODO If only for Fundamentals, create specific controller just for this.
  def update
    @word = Word.find(params[:word_id])
    @games_completed = params[:games_completed].to_i
    @results = UserWord.update_games_completed(
      current_user,
      @word,
      @games_completed
    )
    render json: { response: @results }
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
      flash[:success] = "Success: \'#{@word.name}\' has been removed."
      redirect_to notebook_path
    else
      msg = "Yikes! Removing that word didn\'t work - please try again."
      flash[:danger] = msg
      redirect_to notebook_path
    end
  end
end
