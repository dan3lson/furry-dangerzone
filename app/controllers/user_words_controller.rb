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
      @user_word_game_levels = []
      @user_word_game_levels_before_count = UserWordGameLevel.count

      GameLevel.all.each do |game_level|
        if game_level.game.name == "Fundamentals"
          @user_word_game_levels << UserWordGameLevel.create!(
            user_word: @user_word,
            game_level: game_level
          )
        end
      end

      @synonyms = Synonym.provide(@word.name, @word.part_of_speech)
      @synonyms.delete_if { |synonym| MacmillanDictionary.define(synonym).nil? }
      @pos_synonymous_words = []

      @synonyms.each do |synonym|
        Word.define(synonym)
        @pos_synonymous_words << Word.where(
          name: synonym,
          part_of_speech: @word.part_of_speech
        )
      end

      @pos_synonymous_words.flatten.each { |word| @word.synonyms << word }

      if @user_word_game_levels_before_count == UserWordGameLevel.count - 8
        flash[:success] = "Awesome - you added \'#{@word.name}\'!"
        redirect_to @word
      else
        flash[:danger] = "Yikes! - adding that word didn\'t work. Please try again."
        redirect_to search_path
      end
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
