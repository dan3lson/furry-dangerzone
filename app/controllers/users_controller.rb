class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    render layout: "application_guest"
  end

  def create
    @user = User.new(user_params)
    User.set_up_login_data(@user)
    @user.type = "Teacher"

    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to Leksi!"
      redirect_to school_root_path
    else
      render :new, layout: "application_guest"
    end
  end

  def edit
    @del_account_msg = "Are you sure? All of your Leksi progress will be lost."
  end

  def update
    if @user.update(user_params)
      flash[:success] = "You successfully updated your profile."

      if current_user.is_admin?
        redirect_to admin_users_path
      elsif current_user.is_teacher?
        redirect_to school_classrooms_path
      else
        redirect_to notebook_path
      end
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      flash[:success] = "Success: account deleted for \'#{@user.username}\'."

      if current_user.is_teacher?
        redirect_to :back
      else
        flash[:success] = "Your account was successfully deleted :'("
        redirect_to root_path
      end
    else
      flash[:danger] = "Sorry, something went wrong. Please try again."
      redirect_to root_path
    end
  end

  private

  def user_params
    # TODO Should be in respective namespaced UsersController
    @symbol = if current_user.is_admin?
                :admin
              elsif current_user.is_teacher?
                :teacher
              else
                :student
              end

    params.require(@symbol).permit(
      :username,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :email
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
      redirect_to root_path
    end
  end
end
