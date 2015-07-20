class WordSourcesController < ApplicationController
  def create
    @word = Word.find_by(name: params[:word_name])
    @source_id = params[:word_source][:source_id]

    if @source_id.blank?
      flash[:danger] = "Please select a tag before clicking \'add\'."
      redirect_to @word
    else
      @source = Source.find(@source_id)
      @word_source = WordSource.where(
        word: @word,
        source: @source
      ).first_or_initialize
      if @word_source.save
        msg = "Awesome - you tagged \'#{@source.name}\' to \'#{@word.name}\'!"
        flash[:success] = msg
        redirect_to @word
      else
        flash[:danger] = "Yikes! - something went wrong! Please try again."
        redirect_to @word
      end
    end
  end

  def destroy

  end
end

# Problem 1: how to "remove" a word source
  # or not display as Untagged if it indeed is tagged

# if a word has multiple tags
# and the current user has that word
# remove the Untagged tag from X

# Problem 2: When to remove a word source

# Essentially if no user has that word, that word source
# does not need to exist so:
  # Remove if the word_source word is not included
  # in the user_words.map { |word| word } list
