class LandingPagesController < ApplicationController
  def create
    @landing_page = LandingPage.new
    @landing_page.target = params[:target]
    @landing_page.email = params["landing_page"]["email"]
    
    if @landing_page.save
      flash[:success] = "Thanks - we\'ll be in touch soon!"
    else
      flash[:danger] = "Yikes, that did not work. Please try again."
    end

    redirect_to english_language_learners_path
  end
end
