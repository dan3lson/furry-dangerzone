class StaticPagesController < ApplicationController
  layout "application_guest"

  def guest_home
    redirect_to myLeksi_path if logged_in?
  end

  def about_us
  end

  def english_language_learners
  end
end
