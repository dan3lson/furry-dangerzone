class UserTagsController < ApplicationController
  def destroy
    @user_tag = UserTag.find(params[:id])
    @tag = @user_tag.tag
    @tag_has_other_users = @tag.users.count > 1
    @tag_has_other_words = @tag.words.count > 1

    if @user_tag.destroy
      flash[:success] = "Success: \'#{@tag.name}\' removed."

      @tag.destroy unless @tag_has_other_users || @tag_has_other_words

      redirect_to myTags_path
    else
      flash[:danger] = "Yikes! - something went wrong! Please try again."

      redirect_to myTags_path
    end
  end
end
