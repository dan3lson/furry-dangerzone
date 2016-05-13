class WordsController < ApplicationController
  def index
    @words = Word.all
  end

  def show
    @word = Word.find(params[:id])

    if logged_in?
      @user_word = UserWord.find_by(user: current_user, word: @word)

      if @user_word.freestyle_completed?
        @responses = FreestyleResponse.for(@user_word).sort_by { |fr|
          fr.id
        }.map { |fr| fr.input }

        @semantic_map_responses = @responses[0..2]
        @word_map_responses = @responses[3..5]
        @definition_map_responses = @responses[6..8]
        @sentence_responses = @responses[9..11]
      end

      @tag = Tag.new unless current_user.has_tags?
    end
  end
end
