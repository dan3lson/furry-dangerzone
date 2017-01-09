class TagsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, except: [:new, :create, :edit]

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.where(name: tag_params[:name]).first_or_initialize

    if current_user.has_tag?(@tag)
      flash.now[:warning] = "Whoa there - you already have that tag!"
      render :new
    else
      @user_tag = UserTag.new(user: current_user, tag: @tag)

      if @tag.save && @user_tag.save && current_user.save
        flash[:success] = "Success!"

        redirect_to myTags_path
      else
        render :new
      end
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])

    if @tag.update(tag_params)
      flash[:success] = "Changes successfully made."

      redirect_to "/myTags/#{@tag.id}"
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
      flash[:danger] = "Please log in first."

      redirect_to login_url
    end
  end

  def correct_user
    @tag = Tag.find(params[:id])

    unless current_user.tags.include?(@tag)
      flash[:danger] = "Access denied."

      redirect_to myTags_path
    end
  end
end
