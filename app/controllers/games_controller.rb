class GamesController < ApplicationController
  # This is hit twice because of the respond_to -__-
  def fundamentals
    @chosen_word = Word.find(params[:word_id])
    @synonyms = @chosen_word.synonyms if @chosen_word.has_synonyms?
    @antonyms = @chosen_word.antonyms if @chosen_word.has_antonyms?
    @real_world_examples = RealWorldExample.for(@chosen_word.name)
    @record = true
    @words = [@chosen_word, Word.random(2)].flatten

    if logged_in?
      if current_user.has_incomplete_fundamentals?
        @three_fund_words = current_user.incomplete_fundamentals.shuffle.take(
          3
        ).map { |uw| uw.word }.delete_if { |w| w == @chosen_word }
      end

      if current_user.has_enough_jeopardy_words?
        @three_j_words = current_user.incomplete_freestyles.shuffle.take(
          3
        ).map { |uw| uw.word }
      end
    end

    # show details?, i.e. results or how many questions there are?
    # if not correct, keep track of score for overall Fundamentals score
      # to show if passed or not
    # when all questions answered, display continue btn
    respond_to do |format|
      format.html
      format.json {
        render json: {
          words: @words,
        }
      }
    end
  end

  def jeopardy
    if logged_in?
      @chosen_word = Word.find(params[:word_id])

      if current_user.has_enough_jeopardy_words?
        @valid_jeopardy_words = (current_user.incomplete_jeopardys +
          current_user.completed_jeopardys).map { |uw|
            uw.word }.delete_if { |w| w == @chosen_word
          }

        @second_word = @valid_jeopardy_words.sample
        @valid_jeopardy_words.delete_if { |w| w == @second_word }

        @third_word = @valid_jeopardy_words.sample
        @valid_jeopardy_words.delete_if { |w| w == @third_word }

        @fourth_word = @valid_jeopardy_words.sample

        @jeopardy_words = [
          @chosen_word, @second_word, @third_word, @fourth_word
        ]
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

          if word_has_attribute_value?(@attribute_value)
            if attribute_is_example_sentence_or_definition?(@attribute)
              array_of(w, @attribute).join("; ").gsub(
              "#{w.name}", "______"
              )
            elsif attribute_is_synonym_or_antonym?(@attribute)
              @attribute_value.sample.name
            end
          else
            @attributes[i] = "definition"
            @attribute_value = w.send("definition")
            array_of(w, "definition").join("; ").gsub(
            "#{w.name}", "______"
            )
          end
        end
      end

      @attributes = @attributes.map do |a|
        if a == "definition"
          "<i class='fa fa-list-ol'></i> ".html_safe <<
          "What word matches the definition below?"
        elsif a == "example_sentence"
          "<i class='fa fa-newspaper-o'></i> ".html_safe <<
          "What word best fills in the blank(s) below?"
        elsif a == "synonyms"
          "<i class='fa fa-object-group'></i> ".html_safe <<
          "What word is most similar to the one below?"
        elsif a == "antonyms"
          "<i class='fa fa-object-ungroup'></i> ".html_safe <<
          "What word is the opposite of the one below?"
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
    else
      flash[:danger] = "Yikes! Log in first and then play."

      redirect_to root_path
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
end
