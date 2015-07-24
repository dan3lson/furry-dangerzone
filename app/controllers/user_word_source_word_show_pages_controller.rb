class UserWordSourceWordShowPagesController < ApplicationController
  def destroy
    @tag = Source.find_by(name: params[:tag_name])
    @tag_has_other_users = @tag.users.count > 1
    @user_source = UserSource.find_by(user: current_user, source: @tag)
    @user_word_sources = current_user.user_word_sources
    @num_word_sources = 0
    @num_user_word_sources = 0
    @num_word_sources_destroyed = 0
    @num_user_word_sources_destroyed = 0

    @user_word_sources.each do |user_word_source|
      @word_source = user_word_source.word_source
      @word = @word_source.word
      if @word_source == WordSource.find_by(
        word: user_word_source.word_source.word, source: @tag
      )
        @num_word_sources += 1
        @num_user_word_sources += 1
        if @word_source.destroy && user_word_source.destroy
          @num_word_sources_destroyed += 1
          @num_user_word_sources_destroyed += 1
        end
      end
    end

    if @num_word_sources == @num_word_sources_destroyed &&
       @num_user_word_sources == @num_user_word_sources_destroyed
      flash[:success] = "You removed \'#{@tag.name}\'."
      redirect_to @word
    else
      msg = "Yikes! - removing \'#{@tag.name}\' didn\'t work. "
      flash[:danger] = msg << "Please try again."
      redirect_to @word
    end
  end
end
