class UserWordTagsController < ApplicationController
  def create
    @word = Word.find_by(
      name: params[:name],
      definition: params[:definition]
    )
    @tag_id = params[:user_word_tag][:tag_id]

    if @tag_id.blank?
      flash[:danger] = "Please select a tag before clicking \'add\'."
      redirect_to @word
    else
      @tag = Tag.find(@tag_id)
      @word_tag = WordTag.where(
        word: @word,
        tag: @tag
      ).first_or_initialize

      if @word_tag.save
        @user_word_tag = UserWordTag.new(
          user: current_user,
          word_tag: @word_tag
        )
        current_user.points += 2

        if @user_word_tag.save && current_user.save
          msg = "Awesome - you tagged \'#{@tag.name}\' to \'#{@word.name}\'!"
          flash[:success] = msg
          redirect_to @word
        else
          msg =  "Yikes! - adding a tag didn\'t work! Please try again."
          flash[:danger] = msg
          redirect_to @word
        end

      else
        msg =  "Yikes! - adding a word tag didn\'t work! Please try again."
        flash[:danger] = msg
        redirect_to @word
      end
    end
  end

  def destroy
    @tag = Tag.find_by(name: params[:tag_name])
    @tag_has_other_users = @tag.users.count > 1
    @user_tag = UserTag.find_by(user: current_user, tag: @tag)
    @user_word_tags = current_user.user_word_tags

    @user_word_tags.each do |user_word_tag|
      if user_word_tag.word_tag == WordTag.find_by(
        word: user_word_tag.word_tag.word, tag: @tag
      )
      user_word_tag.destroy
      end
    end

    current_user.points -= 2

    if @user_tag.destroy && current_user.save
      flash[:success] = "You removed \'#{@tag.name}\'."
      @tag.destroy unless @tag_has_other_users
      redirect_to myTags_path
    else
      msg = "Yikes! - removing \'#{@tag.name}\' didn\'t work. "
      flash[:danger] = msg << "Please try again."
      redirect_to myTags_path
    end
  end
end
