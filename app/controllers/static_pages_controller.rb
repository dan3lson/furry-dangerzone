class StaticPagesController < ApplicationController
  def home
    redirect_to words_path if logged_in?
  end

  def menu
  end
end
