class UserSourcesController < ApplicationController
  def destroy
    @user_source = UserSource.find(params[:id])
    @source = @user_source.source
    @source_has_other_users = @source.users.count > 1
    @source_has_other_words = @source.words.count > 1

    if @user_source.destroy
      flash[:success] = "\'#{@source.name}\' has been removed."
      @source.destroy unless @source_has_other_users || @source_has_other_words
      redirect_to myTags_path
    else
      flash[:danger] = "Yikes! - something went wrong! Please try again."
      redirect_to myTags_path
    end
  end
end
