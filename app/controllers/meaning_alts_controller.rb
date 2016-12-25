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
    meaning_alt_params = params[:word][:meaning_alt]
    @meaning_alt = MeaningAlt.new(meaning_alt_params)
    @meaning_alt.word = @word
    @meaning_alt.user = current_user

    if @meaning_alt.blank?
      flash[:danger] = "Please add an example before clicking \'submit\'."
      redirect_to new_word_example_path(@word)
    else
      if @meaning_alt.save
        msg = "Success! Created a meaning alt for #{@meaning_alt.word.name}!"
        flash[:success] = msg
        redirect_to menu_path
      else
        flash.now[:danger] = "Yikes! Something went wrong. Please try again."
        render "versions/show"
      end
    end
  end

  def destroy
    @meaning_alt = MeaningAlt.find(params[:id])

    if @meaning_alt.destroy
      flash[:success] = "MeaningAlt deleted successfully."
      redirect_to reviews_path
    else
      flash.now[:danger] = "MeaningAlt not deleted."
      redirect_to example_path(@meaning_alt)
    end
  end

  private

  def meaning_alt_params
    params.require(:meaning_alt).permit(:word, :text)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."
      redirect_to login_path
    end
  end
end
