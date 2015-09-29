class WordsController < ApplicationController
  def index
    @words = Word.all
  end

  def show
    @word = Word.find(params[:id])
    @user_word = UserWord.find_by(user: current_user, word: @word)

    if @user_word.freestyle_completed?
      @responses = @user_word.uwgl_freestyles.map { |uwgl|
        uwgl.freestyle_responses }.flatten.map { |fr| fr.input }
      @semantic_map_responses = @responses[0..2]
      @word_map_responses = @responses[3..5]
      @definition_map_responses = @responses[6..8]
      @sentence_responses = @responses[9..11]
    end
  end
end
