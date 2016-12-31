class SearchesController < ApplicationController
  def search
    @random_word = Word.random(1).first
    @seventh_grade_words = Word.seventh_grade_objects

    respond_to do |format|
      format.html
      format.js
    end
  end

  def search_results
    @results = if params[:display_button_for] == "user_words"
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
