class StaticPagesController < ApplicationController
  def home
    redirect_to myLeksi_path if logged_in?
    @reviews = Review.limit(5)
  end

  def menu
    @review = Review.new
  end
end
