class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.order("username")
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user_source = UserSource.new(user: @user)
    if @user.save && @user_source.save
      log_in(@user)
      flash[:success] = "Welcome to Leksi!"
      redirect_to root_path
    else
      flash[:danger] = "Yikes! Something went wrong. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Changes successfully made."
      redirect_to @user
    else
      flash[:danger] = "Changes not successfully made."
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "Account deleted; it\'s sad to see you go."
      redirect_to root_path
    else
      flash[:danger] = "Yikes! Something went wrong. Please try again."
      redirect_to menu_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:danger] = "Yikes! That\'s not something you can do."
      redirect_to menu_path
    end
  end
end
