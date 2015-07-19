class UserSourcesController < ApplicationController
  def destroy
    @user_source = UserSource.find(params[:id])
    @source = Source.find_by(name: params[:source_name])

    if @user_source.destroy
      flash[:success] = "\'#{@source.name}\' has been removed."
      redirect_to mySources_path
    else
      flash[:danger] = "Yikes! - something went wrong! Please try again."
      redirect_to mySources_path
    end
  end
end
