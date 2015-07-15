class SourcesController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @current_user_sources = current_user.sources
  end

  def show
    @source = Source.find(params[:id])
  end

  def new
    @source = Source.new
  end

  def create
    @source = Source.new(source_params)
    if current_user.already_has_source?(@source.name)
      flash.now[:warning] = "Whoa there - you already have that source!"
      render :new
    else
      @user_source = UserSource.new(
        user: current_user,
        source: @source
      )
      if @source.save && @user_source.save
        flash[:success] = "You successfully created a new source!"
        redirect_to sources_path
      else
        render :new
      end
    end
  end

  def edit
    @source = Source.find(params[:id])
  end

  def update
    if @source.update(source_params)
      flash[:success] = "Changes successfully made."
      redirect_to @source
    else
      flash[:danger] = "Changes not successfully made."
      render :edit
    end
  end

  def destroy
    @source = Source.find(params[:id])
    if @source.destroy
      flash[:success] = "Source deleted."
      redirect_to sources_path
    else
      flash[:danger] = "Yikes! Something went wrong. Please try again."
      redirect_to sources_path
    end
  end

  private

  def source_params
    params.require(:source).permit(:name)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."
      redirect_to login_url
    end
  end

  def correct_user
    @source = Source.find(params[:id])
    @user_source = UserSource.find_by(user: current_user, source: @source)
    @user = @user_source.user
    unless current_user?(@user)
      flash[:danger] = "Yikes! That\'s not something you can do."
      redirect_to sources_path
    end
  end
end
