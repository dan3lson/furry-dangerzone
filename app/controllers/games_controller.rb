class GamesController < ApplicationController
  def gamezone
  end

  # This action is hit twice because of the respond_to -__-
  # TODO Make it render as cool as the Jeopardy game
  def fundamentals
    @chosen_word = Word.find(params[:word_id])
    @synonyms = @chosen_word.synonyms if @chosen_word.has_synonyms?
    @antonyms = @chosen_word.antonyms if @chosen_word.has_antonyms?
    @real_world_examples = RealWorldExample.for(@chosen_word.name)
    @record = true
    @words = [@chosen_word, Word.random(2)].flatten

    respond_to do |format|
      format.html
      format.json { render json: { words: @words } }
    end
  end

  def jeopardy
    @target_word = Word.find(params[:word_id])
    @words = current_user.get_jeop_words(@target_word)
    @word_names = @words.map(&:name).shuffle
    @rounds = JeopGame.new(@words).rounds
    @jeopardy = { game: @rounds }
    @rows = JeopGame.rows(@rounds, 5)

    respond_to do |format|
      format.js { render template: "games/jeopardy/jeopardy.js.erb" }
    end
  end

  def freestyle
    if logged_in?
      @chosen_word = Word.find(params[:word_id])
      @game_started = true

      if current_user.has_incomplete_freestyles?
        @four_free_words = current_user.incomplete_freestyles.shuffle.take(4).
          map { |uw| uw.word }.delete_if { |w| w == @chosen_word }
      end
    else
      flash[:danger] = "Yikes! Log in first and then play."
      redirect_to root_path
    end
  end

  # Display new words to play after any game is completed
  def play_another
    game = params[:game]
    # if logged_in?
    #   if current_user.has_incomplete_fundamentals?
    #     @three_fund_words = current_user.incomplete_fundamentals.shuffle.take(
    #       3
    #     ).map { |uw| uw.word }.delete_if { |w| w == @chosen_word }
    #   end
    #
    #   if current_user.has_enough_incomplete_jeops?
    #     @three_j_words = current_user.incomplete_freestyles.shuffle.take(
    #       3
    #     ).map { |uw| uw.word }
    #   end
    # end
    respond_to do |format|
      format.js
    end
  end
end
