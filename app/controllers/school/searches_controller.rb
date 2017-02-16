class School::SearchesController < BaseSchoolController
  def search
  end

  def student_words
  end

  def results
    @search = params[:search]

    if @search
      @form_action = params[:form_action]

      if @form_action == "meaning_alt"
        @object = MeaningAlt.new
      elsif @form_action == "e_non_e"
        @object = ExampleNonExample.new
      end

      @input_words = @search.split(",").map(&:strip)
      @word_groups = @input_words.map { |w| Word.define(w) }
                           .flatten
                           .group_by { |w| w.name }

      respond_to do |format|
        format.js
      end
    end
  end
end
