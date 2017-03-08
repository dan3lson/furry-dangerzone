class SearchesController < ApplicationController
  def search
    respond_to do |format|
      format.html
      format.js
    end
  end

  def random
    @word = Word.random(1).first

    respond_to do |format|
      format.js { render template: "searches/words/random.js.erb" }
    end
  end

  def results
    @search = params[:search]

    begin
      if @search
        @input_words = @search.split(",").map(&:strip)
        @word_groups = @input_words.map { |w| Word.define(w) }
                             .flatten
                             .group_by { |w| w.name }

        respond_to do |format|
          format.js
        end
      end
    rescue WordsApi::NoWordError => e
      @error = e.message
    end
  end
end
