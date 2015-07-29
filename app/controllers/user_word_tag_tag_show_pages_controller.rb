class UserWordTagTagShowPagesController < ApplicationController
  def destroy
    @word = Word.find_by(
      name: params[:name],
      definition: params[:definition]
    )
    @tag = Tag.find(params[:tag_id])
    @word_tag = WordTag.find_by(word: @word, tag: @tag)
    @user_word_tag = UserWordTag.find_by(
      user: current_user,
      word_tag: @word_tag
    )
    @word_tag_used_by_other_users = @word_tag.users.count > 1

    if @user_word_tag.destroy
      @word_tag.destroy unless @word_tag_used_by_other_users
      flash[:success] = "You removed \'#{@word.name}\'."
      redirect_to @tag
    else
      msg = "Yikes! - removing \'#{@word.name}\' didn\'t work. "
      flash[:danger] = msg << "Please try again."
      redirect_to @tag
    end
  end
end
