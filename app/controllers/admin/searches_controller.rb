class Admin::SearchesController < BaseAdminController
  def search
  end

  def results
    @search = params[:search]

    if @search
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
