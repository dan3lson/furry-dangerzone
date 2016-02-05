class VersionsController < ApplicationController
  before_action :admin_only, except: [:index, :show]

  def index
    @versions = Version.all
  end

  def show
    @version = Version.find(params[:id])
  end

  def new
    @version = Version.new
  end

  def create
    @version = Version.new(version_params)

    if @version.save
      flash[:success] = "Version \'#{@version.number}\' successfully created."
      redirect_to versions_path
    else
      render :new
    end
  end

  def edit
    @version = Version.find(params[:id])
  end

  def update
    @version = Version.find(params[:id])

    if @version.update(version_params)
      flash[:success] = "Changes successfully made."
      redirect_to @version
    else
      flash[:danger] = "Changes not successfully made."
      render :edit
    end
  end

  def destroy
    @version = Version.find(params[:id])
    
    if @version.destroy
      flash[:success] = "Version deleted."
      redirect_to versions_path
    else
      flash[:danger] = "Yikes! Something went wrong. Please try again."
      redirect_to versions_path
    end
  end

  private

  def version_params
    params.require(:version).permit(:number, :description)
  end

  def admin_only
    unless logged_in? && current_user.is_admin?
      flash[:danger] = "Yikes! Admins only ;)"

      redirect_to root_path
    end
  end
end
