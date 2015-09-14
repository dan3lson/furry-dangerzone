class SearchesController < ApplicationController
  def new
    if Word.has_records?
      @random_word_placeholder = "e.g. #{Word.random}"
    end

    @query = params[:search]

    if @query
      @search_results =
        if @query.blank?
          Word.define(@random_word_placeholder.split(" ")[1])
        else
          Word.define(@query)
      end
    end

    @tre = User.find(3)
    @categories = @tre.tags
    @category_name = params[:category_name]

    if @category_name
      @category_name.squish!
    end
    
    @category = Tag.find_by(name: @category_name)
    @category_words = words_for(@tre, @category)
  end
end
