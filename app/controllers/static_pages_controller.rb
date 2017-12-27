class StaticPagesController < ApplicationController
  layout "application_guest"

  def home
    if logged_in?
      redirect_to notebook_path
    end
  end

  def contact_us
    @form_fields = {
      name: params["cf_name"],
      email: params["cf_email"],
      subject: params["cf_subject"],
      message: params["cf_message"]
    }
    ContactUsMailer.new_message(@form_fields).deliver_later
    flash[:success] = "Thanks for contacting us! We\'ll respond shortly."
    redirect_to root_path
  end

  def research
  end

  def our_approach
  end

  def results
  end

  def terms_of_use
  end

  def privacy_policy
  end
end
