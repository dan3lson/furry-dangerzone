class UserWordTagWordShowPagesController < ApplicationController
  def destroy
    @word = Word.find(params[:word_id])
    @tag = Tag.find_by(name: params[:tag_name])
    @word_tag = WordTag.find_by(word: @word, tag: @tag)
    @word_tag_used_by_other_users = @word_tag.users.count > 1
    @user_word_tag = UserWordTag.find_by(
      user: current_user,
      word_tag: @word_tag
    )

    if @user_word_tag.destroy
      @word_tag.destroy unless @word_tag_used_by_other_users
      flash[:success] = "You removed \'#{@tag.name}\'."
      redirect_to @word
    else
      msg = "Yikes! - removing \'#{@tag.name}\' didn\'t work. "
      flash[:danger] = msg << "Please try again."
      redirect_to @word
    end
  end
end
