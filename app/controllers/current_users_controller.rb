class CurrentUsersController < ApplicationController
  before_action :logged_in_user

  def stats
  end

  def feedback
    @type = params[:type]
    @icon = @type == "bug" ? "bug" : "magic"
  end

  def freestyles
    @frees = current_user.freestyles
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in first."
      redirect_to login_url
    end
  end
end
