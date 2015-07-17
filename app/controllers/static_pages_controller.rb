class StaticPagesController < ApplicationController
  def home
    redirect_to myLeksi_path if logged_in?
  end

  def menu
  end
end
