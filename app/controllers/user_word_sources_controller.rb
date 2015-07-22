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
    @word = Word.find(params[:id])
    @source = Source.find(params[:source_id])
    @word_source = WordSource.find_by(word: @word, source: @source)
    @user_word_source = UserWordSource.find_by(
      user: current_user,
      word_source: @word_source,
    )

    if @user_word_source.destroy
      flash[:success] = "You removed #{@source.name} from \'#{@word.name}\'."
      redirect_to myTags_path
    else
      msg = "Yikes! - removing \'#{@source.name}\' didn\'t work. "
      flash[:danger] = msg << "Please try again."
      redirect_to myTags_path
    end
  end
end
