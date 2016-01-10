class SessionsController < ApplicationController
  def new
    render layout: "application_guest"
  end

  def create
    user = User.find_by(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      @datetime_now = DateTime.now
      user.last_login = @datetime_now

      user.login_history = "" if user.login_history.nil?
      user.login_history += @datetime_now.to_s << "|"

      user.num_logins += 1

      if user.save
        log_in(user)

        redirect_to root_path
      else
        msg = "Updating #{user.username}\'s last_login and num_logins was"
        msg_2 = " NOT successful."
        Rails.logger.error msg << msg_2
      end
    else
      msg = "Yikes! That username/password combination didn\'t work. "
      msg_2 = "Please try again."
      flash.now[:danger] = msg << msg_2

      render :new
    end
  end

  def destroy
    logged_out_user = current_user

    log_out if logged_in?

    redirect_to root_path
  end
end
