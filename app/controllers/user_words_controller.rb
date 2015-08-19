class UserWordsController < ApplicationController
  def create
    @word = Word.find_by(
      name: params[:name],
      definition: params[:definition]
    )
    @user_word = UserWord.new(
      user: current_user,
      word: @word
    )

    if @user_word.save
      @user_word_game_levels_before_count = UserWordGameLevel.count

      GameLevel.create_fundamentals_for(@user_word)

      Thesaurus.insert_words_for(@word, "syn", @word.part_of_speech)

      Thesaurus.insert_words_for(@word, "ant", @word.part_of_speech)

      if @user_word_game_levels_before_count == UserWordGameLevel.count - 8
        msg = "Awesome - you added \'#{@word.name}\'! Tap \'start\' to begin "
        msg_2 = "learning it."
        flash[:success] = msg << msg_2
        redirect_to @word
      else
        msg = "Yikes! - creating Fundamental game_levels didn\'t work."
        flash[:danger] = msg
        redirect_to @word
      end
    else
        msg = "Yikes! - adding that word to your Leksi didn\'t work. "
        msg_2 = " Please try again."
        flash[:danger] = msg << msg_2
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
