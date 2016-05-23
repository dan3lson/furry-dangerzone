class CurrentUsersController < ApplicationController
  before_action :logged_in_user

  def menu
    @review = Review.new
    @feedback = Feedback.new
  end

  def progress
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."

      redirect_to login_url
    end
  end
end
