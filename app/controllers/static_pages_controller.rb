class StaticPagesController < ApplicationController
  layout "application_guest"

  def guest_home
    redirect_to home_path if logged_in?
  end

  def about_us
  end
end
