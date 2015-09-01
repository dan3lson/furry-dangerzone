class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]

  def index
    @reviews = Review.all
  end

  def new
    @version = Version.find(params[:version_id])
    @review = Review.new
  end

  def create
    @version = Version.find(params[:version_id])
    @rating = params[:review][:rating]
    @review = Review.new(review_params)
    @review.version = @version
    @review.user = current_user

    if @rating.blank?
      flash[:danger] = "Please select a rating before clicking \'submit\'."
      redirect_to new_version_review_path(@version)
    else
      if @review.save
        msg = "Thanks for rating Leksi Version #{@version.number}!"
        flash[:success] = msg
        redirect_to menu_path
      else
        flash.now[:danger] = "Yikes! Something went wrong. Please try again."
        render "versions/show"
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      flash[:success] = "Review deleted successfully."
      redirect_to reviews_path
    else
      flash.now[:danger] = "Review not deleted."
      redirect_to review_path(@review)
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."
      redirect_to login_path
    end
  end
end
