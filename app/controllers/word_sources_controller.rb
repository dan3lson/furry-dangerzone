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
end
