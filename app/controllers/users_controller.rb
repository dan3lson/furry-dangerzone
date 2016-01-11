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
    @goal = params[:weekly_goal]
    @user.goal = @goal if @goal

    User.set_up_login_data(@user)

    if @user.save
      @param_words = params[:word_ids]
      @param_completed_fund = params[:completed_fund]

      if @param_words.blank?
        @words_successfully_added = UserWord.add_words(@user, Word.random(5))
      else
        @words = Word.find(@param_words.chop.reverse.chop.reverse.split)
        @words_successfully_added = UserWord.add_words(@user, @words)
      end

      if @words_successfully_added == 5 && !@param_completed_fund.blank?
        @completed_fund = Word.find(@param_completed_fund)

        @time_spent = params[:time_spent]
        @game_name = params[:game_name]

        @results = UserWord.mark_fundamentals_completed(
        @user, @completed_fund
        )

        @gs_results = GameStat.update_user_word_game_stats(
        @user, @completed_fund, @game_name, @time_spent
        )

        logger.info(@results)
        logger.info(@gs_results)
      else
        logger.error { "#{@user.username} adding five words didn't work."}
      end

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
