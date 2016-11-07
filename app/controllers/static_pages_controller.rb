class StaticPagesController < ApplicationController
  layout "application_guest"

  def guest_home
    redirect_to myLeksi_path if logged_in?
  end

  def contact_us
    @form_fields = {
      name: params["cf_name"],
      email: params["cf_email"],
      school_name: params["cf_school_name"],
      comments: params["cf_comments"]
    }

    ContactUsMailer.new_message(@form_fields).deliver_later

    flash[:success] = "Thanks for reaching out! We\'ll respond shortly :)."

    redirect_to root_path
  end

  def about_us
  end
end
