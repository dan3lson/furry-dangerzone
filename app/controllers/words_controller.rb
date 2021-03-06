class WordsController < ApplicationController
  def show
    @word = Word.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def thesaurus
    @word_name = params[:word_name]
    @synonyms = Thesaurus.synonyms(@word_name)
    @antonyms = Thesaurus.antonyms(@word_name)
    render json: [@synonyms, @antonyms]
  end
end
