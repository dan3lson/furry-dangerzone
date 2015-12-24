class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @filter = params[:filter]

    if @filter
      if @filter == "latest"
        @users = User.order("created_at DESC")
      end
    else
      @users = User.order("username ASC")
    end

    @user_count = User.all.count
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new

    render layout: "public_application"
  end

  def create
    @user = User.new(user_params)
    @datetime_now = DateTime.now
    @user.last_login = @datetime_now
    @user.login_history = ""
    @user.login_history += @datetime_now.to_s << "|"
    @user.num_logins += 1

    if @user.save
      @words_successfully_added = UserWord.add_first_four_words(@user)

      if @words_successfully_added == 4
        flash[:success] = "Welcome to Leksi!"
      else
        logger.error { "#{@user.username} adding four words didn't work."}
      end

      log_in(@user)

      redirect_to root_path
    else
      flash[:danger] = "Yikes! Something went wrong. Please try again."

      render :new
    end
  end

  def edit
    @delete_account_msg = "Are you sure? All of your Leksi data will be lost."
  end

  def update
    if @user.update(user_params)
      flash[:success] = "You successfully updated your profile."

      redirect_to menu_path
    else
      flash[:danger] = "Yikes! Profile updates not successfully made."

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
    params.require(:user).permit(:first_name, :last_name, :username,
      :email, :password, :password_confirmation
    )
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
