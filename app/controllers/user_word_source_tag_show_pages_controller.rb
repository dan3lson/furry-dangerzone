class UserWordSourceTagShowPagesController < ApplicationController
  def destroy
    @word = Word.find_by(name: params[:word_name])
    @tag = Source.find(params[:tag])
    @word_source = WordSource.find_by(word: @word, source: @tag)
    @user_word_source = current_user.user_word_sources.where(
      word_source: @word_source
    ).first
    @word_source_used_by_multiple_users = @word_source.users.count > 1
    if @user_word_source.destroy
      @word_source.destroy unless @word_source_used_by_multiple_users
      flash[:success] = "You removed \'#{@word.name}\'."
      redirect_to @tag
    else
      msg = "Yikes! - removing \'#{@word.name}\' didn\'t work. "
      flash[:danger] = msg << "Please try again."
      redirect_to @tag
    end
  end
end
