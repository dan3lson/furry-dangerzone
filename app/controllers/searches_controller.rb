class SearchesController < ApplicationController
  def search
  end

  def search_results
    @results = if params[:rand]
                 Word.define(Word.random(1).first.name)
               elsif params[:display_button_for] == "user_words"
                 if current_user.has_words?
                   current_user.words
                 else
                   "You haven\'t added any words to your myLeksi yet."
                 end
               else
                 Word.define(params[:search]) if params[:search]
               end
    @display_button_for = params[:display_button_for]

    respond_to do |format|
      format.js
    end
  end

  def student_words
  end
end
