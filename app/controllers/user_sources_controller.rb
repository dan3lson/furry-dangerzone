class UserSourcesController < ApplicationController
  def destroy
    @user_source = UserSource.find(params[:id])
    @source = @user_source.source
    # @user_word_source = UserWordSource.find_by(
    #   user: current_user,
    #   word_source: WordSource.find_by(
    #
    #   )
    # )
    # binding.pry
    if @user_source.destroy
      flash[:success] = "\'#{@source.name}\' has been removed."
      redirect_to myTags_path
    else
      flash[:danger] = "Yikes! - something went wrong! Please try again."
      redirect_to myTags_path
    end
  end
end
