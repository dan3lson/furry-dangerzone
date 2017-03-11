class CurrentUsersController < ApplicationController
  before_action :logged_in_user

  def home
    @user_word = @current_user.rand_incomplete_word
  end

  def settings
  end

  def progress
  end

  def feedback
    @type = params[:type]
    @icon = @type == "bug" ? "bug" : "magic"
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in first."
      redirect_to login_url
    end
  end
end
