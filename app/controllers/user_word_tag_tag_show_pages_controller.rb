class UserWordTagTagShowPagesController < ApplicationController
  def destroy
    @word = Word.find_by(name: params[:word_name])
    @tag = Tag.find(params[:tag])
    @word_tag = WordTag.find_by(word: @word, tag: @tag)
    @user_word_tag = current_user.user_word_tags.where(
      word_tag: @word_tag
    ).first
    @word_tag_used_by_multiple_users = @word_tag.users.count > 1
    if @user_word_tag.destroy
      @word_tag.destroy unless @word_tag_used_by_multiple_users
      flash[:success] = "You removed \'#{@word.name}\'."
      redirect_to @tag
    else
      msg = "Yikes! - removing \'#{@word.name}\' didn\'t work. "
      flash[:danger] = msg << "Please try again."
      redirect_to @tag
    end
  end
end
