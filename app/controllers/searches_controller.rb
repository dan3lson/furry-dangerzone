class SearchesController < ApplicationController
  def new
    unless Word.first.nil?
      @random_word_placeholder = "e.g. #{Word.all.sample.name}"
    end
    @query = params[:search]
    if @query
      #@search_results = Word.define(@query)
      macmillan_word = MacmillanDictionary.define(@query)
      @word = Word.new(
        name: @query,
        phonetic_spelling: macmillan_word.phonetic_spelling,
        part_of_speech: macmillan_word.part_of_speech,
        definition: macmillan_word.definition,
        example_sentence: macmillan_word.example_sentence
      )
      @search_results = [@word]
    end
    @current_user_sources = current_user.sources
  end
end
