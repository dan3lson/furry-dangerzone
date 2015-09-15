class StaticPagesController < ApplicationController
  layout "public_application"

  def guest_home
    redirect_to home_path if logged_in?

    @reviews = Review.limit(5)
  end
end
