class UserWordTagWordShowPagesController < ApplicationController
  def destroy
    @tag = Tag.find_by(name: params[:tag_name])
    @tag_has_other_users = @tag.users.count > 1
    @user_tag = UserTag.find_by(user: current_user, tag: @tag)
    @user_word_tags = current_user.user_word_tags
    @num_word_tags = 0
    @num_user_word_tags = 0
    @num_word_tags_destroyed = 0
    @num_user_word_tags_destroyed = 0

    @user_word_tags.each do |user_word_tag|
      @word_tag = user_word_tag.word_tag
      @word = @word_tag.word
      if @word_tag == WordTag.find_by(
        word: user_word_tag.word_tag.word, tag: @tag
      )
        @num_word_tags += 1
        @num_user_word_tags += 1
        if @word_tag.destroy && user_word_tag.destroy
          @num_word_tags_destroyed += 1
          @num_user_word_tags_destroyed += 1
        end
      end
    end

    if @num_word_tags == @num_word_tags_destroyed &&
       @num_user_word_tags == @num_user_word_tags_destroyed
      flash[:success] = "You removed \'#{@tag.name}\'."
      redirect_to @word
    else
      msg = "Yikes! - removing \'#{@tag.name}\' didn\'t work. "
      flash[:danger] = msg << "Please try again."
      redirect_to @word
    end
  end
end
