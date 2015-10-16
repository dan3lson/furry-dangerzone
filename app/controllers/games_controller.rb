class GamesController < ApplicationController
  def fundamentals
    @chosen_word = Word.find(params[:word_id])
    @synonyms = @chosen_word.synonyms if @chosen_word.has_synonyms?
    @antonyms = @chosen_word.antonyms if @chosen_word.has_antonyms?
    @real_world_examples = RealWorldExample.for(@chosen_word.name)

    if current_user.has_incomplete_fundamentals?
      @three_fund_words = current_user.incomplete_fundamentals.shuffle.take(3).
        map { |uw| uw.word }.delete_if { |w| w == @chosen_word }
    end

    if current_user.has_enough_jeopardy_words?
      @three_j_words = current_user.incomplete_freestyles.shuffle.take(3).
        map { |uw| uw.word }
    end
  end

  def jeopardy
    @chosen_word = Word.find(params[:word_id])

    if current_user.has_enough_jeopardy_words?
      @valid_jeopardy_words = (current_user.incomplete_jeopardys +
        current_user.completed_jeopardys).map { |uw|
          uw.word }.delete_if { |w| w == @chosen_word }

      @second_word = @valid_jeopardy_words.sample
      @valid_jeopardy_words.delete_if { |w| w == @second_word }

      @third_word = @valid_jeopardy_words.sample
      @valid_jeopardy_words.delete_if { |w| w == @third_word }

      @fourth_word = @valid_jeopardy_words.sample

      @jeopardy_words = [@chosen_word, @second_word, @third_word, @fourth_word]
      @jeopardy_words_ids = @jeopardy_words.map { |w| w.id }
      @jeopardy_words_names = @jeopardy_words.map { |w| w.name }
      @jeopardy_lineup = (@jeopardy_words * 5).shuffle

      @jeopardy_lineup_names = @jeopardy_lineup.map { |w| w.name }

      @attributes = (
        %w(definition example_sentence synonyms antonyms) * 5
      ).shuffle
      @attribute_values = @jeopardy_lineup.each_with_index.map do |w, i|
        @attribute = @attributes[i]
        @attribute_value = w.send(@attribute)

        if @attribute_value.empty?
          @attributes[i] = "definition"
          @attribute_value = w.send("definition")
          top_three_entries_for(w, "definition").join("; ").gsub(
            "#{w.name}", "______"
          )
        else
          if @attribute == "example_sentence" || @attribute == "definition"
            top_three_entries_for(w, @attribute).join("; ").gsub(
              "#{w.name}", "______"
            )
          elsif @attribute.end_with?("onyms")
            @attribute_value.sample.name
          end
        end
      end
    end

    respond_to do |format|
      format.html
      format.json {
        render json: {
          word_ids: @jeopardy_words_ids,
          word_names: @jeopardy_words_names,
          jeopardy_lineup_names: @jeopardy_lineup_names,
          attributes_array: @attributes,
          attribute_values: @attribute_values
        }
      }
    end
  end

  def freestyle
    @chosen_word = Word.find(params[:word_id])

    if current_user.has_incomplete_freestyles?
      @four_free_words = current_user.incomplete_freestyles.shuffle.take(4).
        map { |uw| uw.word }.delete_if { |w| w == @chosen_word }
    end
  end
end
