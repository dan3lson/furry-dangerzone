class ExamplesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]

  def index
    @examples = Example.all
  end

  def new
    @word = Word.find(params[:word_id])
    @example = Example.new
  end

  def create
    @word = Word.find(params[:word_id])
    @example = params[:review][:rating]
    @example = Example.new(example_params)
    @example.word = @word
    @example.user = current_user

    if @example.blank?
      flash[:danger] = "Please add an example before clicking \'submit\'."
      redirect_to new_word_example_path(@word)
    else
      if @example.save
        msg = "Thanks for creating an example for word #{@example.word.name}!"
        flash[:success] = msg
        redirect_to menu_path
      else
        flash.now[:danger] = "Yikes! Something went wrong. Please try again."
        render "versions/show"
      end
    end
  end

  def destroy
    @example = Example.find(params[:id])

    if @example.destroy
      flash[:success] = "Example deleted successfully."
      redirect_to reviews_path
    else
      flash.now[:danger] = "Example not deleted."
      redirect_to example_path(@example)
    end
  end

  private

  def example_params
    params.require(:example).permit(:word, :text)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."
      redirect_to login_path
    end
  end
end
