class Admin::SearchesController < BaseAdminController
  def search
  end

  def results
    @search = params[:search]

    if @search
      @input_words = @search.split(",").map(&:strip)
      @words = @input_words.map { |w| Word.define(w) }.flatten

      respond_to do |format|
        format.js
      end
    end
  end
end
