class MeaningAltsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]

  def index
    @meaning_alts = MeaningAlt.all
  end

  def new
    @word = Word.find(params[:word_id])
    @meaning_alt = MeaningAlt.new
  end

  def create
    @word = Word.find(params[:word_id])
    @meaning_alt = MeaningAlt.new(meaning_alt_params)
    @meaning_alt.word = @word

    if @meaning_alt.save
      flash[:success] = [
        "Success! Thanks for creating a meaning alternative for ",
        "#{@meaning_alt.word.name}!"
      ].join
    else
      flash.now[:danger] = "Yikes! Something went wrong. Please try again."
    end

    redirect_to seventh_grade_words_path
  end

  def destroy
    @meaning_alt = MeaningAlt.find(params[:id])

    if @meaning_alt.destroy
      flash[:success] = "MeaningAlt deleted successfully."
    else
      flash.now[:danger] = "MeaningAlt not deleted."
    end

    redirect_to root_path
  end

  private

  def meaning_alt_params
    params.require(:meaning_alt).permit(:text, :feedback)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."
      redirect_to login_path
    end
  end
end
