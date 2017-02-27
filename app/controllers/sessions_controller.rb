class SessionsController < ApplicationController
  def new
    render layout: "application_guest"
  end

  def create
    user = User.find_by(email: params[:session][:email_or_username]) ||
           User.find_by(username: params[:session][:email_or_username])

    if user && user.authenticate(params[:session][:password])
      @datetime_now = DateTime.now
      user.last_login = @datetime_now
      user.login_history = "" if user.login_history.nil?
      user.login_history += @datetime_now.to_s << "|"
      user.num_logins += 1

      unless user.save
        msg = user.errors.full_messages
        Rails.logger.error "ERROR updating #{user.username}\' info: #{msg}."
      end

      log_in(user)

      if user.is_admin?
        redirect_to root_path
      elsif user.is_teacher? || user.is_demo_teacher?
        redirect_to school_root_path
      else
        redirect_to root_path
      end
    else
      msg = "That info didn\'t work. Please try again."
      flash.now[:danger] = msg
      render :new
    end
  end

  def destroy
    logged_out_user = current_user
    log_out if logged_in?
    redirect_to root_path
  end
end
