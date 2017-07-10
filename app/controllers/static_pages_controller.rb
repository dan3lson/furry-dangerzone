class StaticPagesController < ApplicationController
  layout "application_guest"

  def home
    if logged_in?
      if current_user.is_admin?
        redirect_to admin_settings_path
      else
        redirect_to home_path
      end
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
    flash[:success] = "Thanks for contacting us! We\'ll respond shortly :)."
    redirect_to root_path
  end

  def research
  end

  def our_approach
  end

  def results
  end

  def spelling_bee
    flash[:success] = "We\'re updating the Harlem Spelling Bee site. Stay tuned!"
    redirect_to blog_first_harlem_spelling_bee_path
    # render layout: "application_spelling_bee"
  end
end
