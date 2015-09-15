class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      log_in(user)

      user.last_login = DateTime.now

      user.save

      redirect_to root_path
    else
      flash.now[:danger] = "Invalid username and / or password combination."
      render :new
    end
  end

  def destroy
    logged_out_user = current_user

    log_out if logged_in?

    redirect_to root_path
  end
end
