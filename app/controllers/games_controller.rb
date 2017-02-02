class GamesController < ApplicationController
  def gamezone
  end

  def fundamentals
    @target_word = Word.find(params[:word_id])
    @synonyms = @target_word.synonyms if @target_word.has_synonyms?
    @antonyms = @target_word.antonyms if @target_word.has_antonyms?
    @words = [@target_word, Word.random(2)].flatten

    respond_to do |format|
      format.js { render template: "games/fundamentals/fundamentals.js.erb"}
    end
  end

  def jeopardy
    @target_word = Word.find(params[:word_id])
    @words = current_user.get_jeop_words(@target_word)
    @word_names = @words.map(&:name).shuffle
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
    @sent_stems = @target_word.sent_stems
    @directions = "Complete the sentences below."
    # respond_to(:js)
    respond_to do |format|
      format.js { render template: "games/freestyle/freestyle.js.erb" }
    end
  end
end
