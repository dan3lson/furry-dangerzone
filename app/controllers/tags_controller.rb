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
    @tag = Tag.new(tag_params)

    if current_user.has_tag?(@tag)
      msg = [
        "Hey #{current_user.username}, you already have a tag named ",
        "\'#{@tag.name}\'. Change the name and then try creating it again."
      ].join
      flash.now[:warning] = msg
      render :new
    else
      if @tag.save
        current_user.tags << @tag
        flash[:success] = "Success! Add words here for better organization."
        redirect_to "/myTags/#{@tag.id}"
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
      flash[:success] = "Success - tag updated!"
      redirect_to "/myTags/#{@tag.id}"
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])

    if @tag.destroy
      flash[:success] = "That tag was successfully deleted."
      redirect_to myTags_path
    else
      flash[:danger] = "Sorry, something went wrong. Please try again."
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
