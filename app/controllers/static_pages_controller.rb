class StaticPagesController < ApplicationController
  def duolingo
  end
  
  def guest_home
    redirect_to home_path if logged_in?
    @reviews = Review.limit(5)
  end

  def menu
    @review = Review.new
  end
end
