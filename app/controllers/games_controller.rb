class GamesController < ApplicationController
  def gamezone
  end

  def fundamentals
    @target_word = Word.find(params[:word_id])
    @user_word = UserWord.object(current_user, @target_word)
    @game_to_play = params[:game] || @user_word.current_game
    @available_games = {
      "pronun": @target_word.has_pronunciation?,
      "dec_dec": @target_word.has_meaning_alts?,
      "ex_non_ex": @target_word.has_ex_non_exs?,
      "syns_vs_ants": @target_word.has_syns_or_ants?
    }

    respond_to do |format|
      format.js { render template: "games/fundamentals/fundamentals.js.erb"}
    end
  end

  def jeopardy
    @target_word = Word.find(params[:word_id])
    @words = current_user.get_jeop_words(@target_word).shuffle
    @rounds = JeopGame.new(@words).rounds
    @jeopardy = { game: @rounds }
    @rows = JeopGame.rows(@rounds, 5)
    @directions = "Click on any Linero to answer the question displayed below."

    respond_to do |format|
      format.js { render template: "games/jeopardy/jeopardy.js.erb" }
    end
  end

  def freestyle
    @target_word = Word.find(params[:word_id])
    @user_word = UserWord.object(current_user, @target_word)
    @sent_stems = @target_word.sent_stems
    @current_game = UserWord.object(current_user, @target_word).current_game
    @game_to_play = params[:game]
    @available_games = {
      "sent_stems": @target_word.has_sent_stems?,
      "describe_me": @target_word.has_describe_mes?,
    }

    respond_to do |format|
      format.js { render template: "games/freestyle/freestyle.js.erb" }
    end
  end
end
