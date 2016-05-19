class TagGamesController < ApplicationController
  def jeopardy
    if logged_in?
      @tag = Tag.find(params[:tag_id])
      @chosen_word = words_for(current_user, @tag).sample

      if enough_jeopardy_words_exist?(current_user, @tag)
        @valid_jeopardy_words = (incomplete_jeopardys(current_user, @tag) +
          completed_jeops(current_user, @tag)).map { |uw|
            uw.word }.delete_if { |w| w == @chosen_word }

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
        format.html {
          render template: "games/jeopardy.html.erb"
        }
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
end
