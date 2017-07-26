class UserWordsController < ApplicationController
  def create
    @word = Word.find(params[:word_id])
    @user_word = UserWord.new(user: current_user, word: @word)
    @play = params[:search_btn]
    fund_game_link = "/fundamentals?word_id=#{@word.id}"
    @created = false

    if current_user.has_word?(@word)
      redirect_to fund_game_link if @play
    else
      if @user_word.save
        @created = true

        if @play
          redirect_to fund_game_link
        else
          respond_to do |format|
            format.js
          end
        end
      else
        msg = "Saving that word didn\'t work. Please try again."
        flash[:danger] = msg
        redirect_to search_path
      end
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
