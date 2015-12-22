class UserWordsController < ApplicationController
  def create
    @word = Word.find(params[:id])
    @user_word = UserWord.new(user: current_user, word: @word)
    @play = params[:search_btn]

    if @user_word.save
      Thesaurus.insert_words_for(@word, "syn", @word.part_of_speech)

      Thesaurus.insert_words_for(@word, "ant", @word.part_of_speech)

      if @play
        redirect_to "/fundamentals?word_id=#{@word.id}"
      else
        flash[:success] = "Success! You now have \'#{@word.name}\'."

        redirect_to search_path
      end
    else
      msg = "Yikes! Adding that word to your Leksi didn\'t work. "
      msg_2 = "Please try again."
      flash[:danger] = msg << msg_2

      redirect_to search_path
    end
  end

  def update
    @word = Word.find(params[:word_id])
    @user_word = UserWord.find_by(user: current_user, word: @word)

    @user_word.games_completed = 1

    if @user_word.save
      render json: {
        errors: "Success: UW #{@user_word.id}\'s games_completed now at 1."
      }
    else
      render json: {
        errors: "ERROR: UW #{@user_word.id}\'s games_completed not at 1."
      }
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
      flash[:success] = "Success: \'#{@word.name}\' has been removed."

      redirect_to myLeksi_path
    else
      msg = "Yikes! Removing that word didn\'t work - please try again."
      flash[:danger] = msg

      redirect_to myLeksi_path
    end
  end
end
