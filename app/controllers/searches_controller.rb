class SearchesController < ApplicationController
  def dictionary
  end

  def random
    @word = Word.random(1).first

    respond_to do |format|
      format.js { render template: "searches/words/random.js.erb" }
    end
  end

  def section
    @section = params[:name]
    @word_groups = Word.send(@section).group_by(&:name)

    respond_to do |format|
      format.js { render template: "searches/words/section.js.erb" }
    end
  end

  def results
    @search = params[:search]
    @account_type = params[:account_type]

    begin
      if @search
        if @search.empty?
          @word_groups = nil
          @error = "Please click \'Dictionary\' and type in a word."
        else
          @input_words = @search.split(",").map(&:strip)
          @word_groups = @input_words.map { |w| Word.define(w) }
                                     .flatten
                                     .group_by { |w| w.name }
        end

        respond_to do |format|
          format.js
        end
      end
    rescue WordsApi::NoWordError => e
      @error = e.message
    end
  end
end
