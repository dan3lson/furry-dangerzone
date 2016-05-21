class CurrentUsersController < ApplicationController
  before_action :logged_in_user

  def menu
    @review = Review.new
    @feedback = Feedback.new
  end

  def myLeksi
    @current_user_words = current_user.sort_words_by_progress("ASC")
                                      .includes(:word)
                                      .map { |uw| uw.word }
    page = params[:page] ? params[:page].to_i - 1 : 1
    @current_user_words_pag = @current_user_words.paginate(
      page: page,
      per_page: 15
    )
    @current_user_words_count = @current_user_words.count

    respond_to do |format|
      format.html
      format.js
    end
  end

  def myLeksi_show
    @word = Word.find(params[:id])
    @user_word = UserWord.object(current_user, @word)
  end

  def progress
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."

      redirect_to login_url
    end
  end
end
