class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
  end

  def new
    @user = Brainiac.new
    render layout: "application_guest"
  end

  def create
    @user = Brainiac.new(user_params)
    User.set_up_login_data(@user)

    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to Leksi!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @del_account_msg = "Are you sure? All of your Leksi progress will be lost."
  end

  def update
    if @user.update(user_params)
      flash[:success] = "You successfully updated your profile."
      redirect_to settings_path
    else
      flash[:danger] = "Yikes! Profile updates not successfully made."
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "Account deleted for username: #{@user.username}."

      if current_user.is_teacher?
        redirect_to :back
      else
        flash[:success] = "Your account was successfully deleted :'("
        redirect_to root_path
      end
    else
      flash[:danger] = "Sorry, something went wrong. Please try again."
      redirect_to settings_path
    end
  end

  private

  def user_params
    @symbol = if @user.is_admin?
                :admin
              elsif @user.is_teacher?
                :teacher
              else
                :student
              end
    params.require(@symbol).permit(
      :first_name,
      :last_name,
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in first."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])

    unless current_user?(@user)
      flash[:danger] = "Access denied."
      redirect_to settings_path
    end
  end
end
