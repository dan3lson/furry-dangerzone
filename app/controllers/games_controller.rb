class GamesController < ApplicationController
  def fundamentals
    @chosen_word = Word.find(params[:word_id])
    @synonyms = @chosen_word.synonyms if @chosen_word.has_synonyms?
    @antonyms = @chosen_word.antonyms if @chosen_word.has_antonyms?
    @real_world_examples = RealWorldExample.for(@chosen_word.name)
  end

  def jeopardy
    @chosen_word = Word.find(params[:word_id])
  end

  def jeopardy_game_words
    @chosen_word = Word.find(params[:word_id])
    @incomplete_jeopardys = current_user.incomplete_jeopardys.map { |uw|
      uw.word
    }.delete_if { |w| w == @chosen_word }

    @second_word = @incomplete_jeopardys.sample

    @incomplete_jeopardys.delete_if { |w| w == @second_word }

    @third_word = @incomplete_jeopardys.sample

    @incomplete_jeopardys.delete_if { |w| w == @third_word }

    @fourth_word = @incomplete_jeopardys.sample
    @jeopardy_words = [@chosen_word, @second_word, @third_word, @fourth_word]
    @jeopardy_words_ids = @jeopardy_words.map { |w| w.id }
    @jeopardy_words_names = @jeopardy_words.map { |w| w.name }
    @jeopardy_lineup = @jeopardy_words * 5

    3.times do
      @jeopardy_lineup.shuffle!
    end

    @jeopardy_lineup_names = @jeopardy_lineup.map { |w| w.name }

    # each word has a definition -> 20 - 4 = 16
    # So starting with 16 available question types, first grab all of the
      # available synonyms and antonyms and then until the @attriutes = 20, fill
      #in the remaining number with a random questiont ype
    @attributes = (%w(definition example_sentence) * 10).shuffle
    @attribute_values = @jeopardy_lineup.each_with_index.map do |w, i|
      @attribute = @attributes[i]

      if w.send(@attribute).empty?
        "Nice - you get a freebie! Tap <strong>#{w.name}</strong> to continue."
      else
        if @attribute == "example_sentence"
          top_three_entries_for(w, @attribute).join("; ").gsub(
            "#{w.name}", "______"
          )
        else
          top_three_entries_for(w, @attribute).join("; ")
        end
      end
    end

    render json: {
      word_ids: @jeopardy_words_ids,
      word_names: @jeopardy_words_names,
      jeopardy_lineup_names: @jeopardy_lineup_names,
      attributes_array: @attributes,
      attribute_values: @attribute_values
    }
  end
end
