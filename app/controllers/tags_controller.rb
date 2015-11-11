class TagsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @words_count = words_for(current_user, @tag).count

    if @words_count > 0
      @completed_games = completed_funds(current_user, @tag).count +
                               completed_jeops(current_user, @tag).count +
                               completed_frees(current_user, @tag).count
      @total_games = @words_count * 3
      @tag_game_progress = (@completed_games / @total_games.to_f * 100).round

      if incomplete_fundamentals_exist?(current_user, @tag)
        @rand_incomp_fund_word_id = incomplete_fundamentals(
          current_user, @tag
        ).sample.word.id
      end

      if incomplete_jeopardys_exist?(current_user, @tag)
        @rand_incomp_jeop_word_id = incomplete_jeopardys(
          current_user, @tag
        ).sample.word.id
      end

      if incomplete_freestyles_exist?(current_user, @tag)
        @rand_incomp_free_word_id = incomplete_freestyles(
          current_user, @tag
        ).sample.word.id
      end
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.where(name: tag_params[:name]).first_or_initialize


    if current_user.already_has_tag?(@tag)
      flash.now[:warning] = "Whoa there - you already have that tag!"

      render :new
    else
      @user_tag = UserTag.new(user: current_user, tag: @tag)

      if @tag.save && @user_tag.save && current_user.save
        flash[:success] = "Success!"

        redirect_to root_path
      else
        render :new
      end
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    if @tag.update(tag_params)
      flash[:success] = "Changes successfully made."
      redirect_to @tag
    else
      flash[:danger] = "Changes not successfully made."
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])

    if @tag.destroy
      flash[:success] = "Tag deleted."
      redirect_to myTags_path
    else
      flash[:danger] = "Yikes! Something went wrong. Please try again."
      redirect_to myTags_path
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."
      redirect_to login_url
    end
  end

  def correct_user
    @tag = Tag.find(params[:id])
    @user_tag = UserTag.find_by(user: current_user, tag: @tag)

    unless current_user.tags.include?(@tag)
      flash[:danger] = "Yikes! That\'s not something you can do."

      redirect_to myTags_path
    end
  end
end
