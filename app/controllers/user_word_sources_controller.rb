class UserWordSourcesController < ApplicationController
  def create
    @word = Word.find_by(name: params[:word_name])
    @source_id = params[:user_word_source][:source_id]

    if @source_id.blank?
      flash[:danger] = "Please select a tag before clicking \'add\'."
      redirect_to @word
    else
      @source = Source.find(@source_id)
      @word_source = WordSource.where(
        word: @word,
        source: @source
      ).first_or_initialize

      if @word_source.save
        @user_word_source = UserWordSource.new(
          user: current_user,
          word_source: @word_source
        )

        if @user_word_source.save
          msg = "Awesome - you tagged \'#{@source.name}\' to \'#{@word.name}\'!"
          flash[:success] = msg
          redirect_to @word
        else
          msg =  "Yikes! - adding a tag didn\'t work! Please try again."
          flash[:danger] = msg
          redirect_to @word
        end

      else
        msg =  "Yikes! - adding a word source didn\'t work! Please try again."
        flash[:danger] = msg
        redirect_to @word
      end
    end
  end

  def destroy
    @source = Source.find_by(name: params[:source_name])
    @source_has_other_users = @source.users.count > 1
    @user_source = UserSource.find_by(user: current_user, source: @source)
    @user_word_sources = current_user.user_word_sources
    @user_word_sources.each do |user_word_source|
      user_word_source.destroy
    end

    if @user_source.destroy && @user_word_sources.count == 0
      flash[:success] = "You removed \'#{@source.name}\'."
      @source.destroy unless @source_has_other_users
      redirect_to myTags_path
    else
      msg = "Yikes! - removing \'#{@source.name}\' didn\'t work. "
      flash[:danger] = msg << "Please try again."
      redirect_to myTags_path
    end
  end
end
