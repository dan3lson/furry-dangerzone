class SearchesController < ApplicationController
  def new
    if Word.has_records?
      @random_word_placeholder = "e.g. #{Word.random}"
    end
    @query = params[:search]
    if @query
      if @query.blank?
        @query = @random_word_placeholder.split(" ")[1]
      end
      if Word.define(@query)
        @search_results = [Word.define(@query)]
      else
        macmillan_word = MacmillanDictionary.define(@query)
        if macmillan_word.nil?
          msg = "Yikes! We couldn\'t find '#{@query}'. Please search again!"
          flash.now[:danger] = msg
        else
          word = Word.find_or_create_by(
            name: @query,
            phonetic_spelling: macmillan_word.phonetic_spelling,
            part_of_speech: macmillan_word.part_of_speech,
            definition: macmillan_word.definition,
            example_sentence: macmillan_word.example_sentence
          )
          @search_results = [word]
        end
      end
    end
    @current_user_sources = current_user.sources
  end
end
