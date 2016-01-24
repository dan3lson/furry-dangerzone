class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]

  def index
    @comments = Comment.all

    render layout: "application_guest" unless logged_in
  end

  def new
    @blog = Blog.find(params[:blog_id])
    @comment = Comment.new
  end

  def create
    @blog = Blog.find(params[:blog_id])
    @blog_url = params[:blog_url]
    @comment = Comment.new(comment_params)
    @comment.blog = @blog
    @comment.user = current_user if logged_in

    if @comment.save
      flash[:success] = "Thanks for commenting on this blog post!"
    else
      flash.now[:danger] = "Yikes! Something went wrong. Please try again."
    end

    redirect_to @blog_url
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:success] = "Comment deleted successfully."

      redirect_to comments_path
    else
      flash.now[:danger] = "Comment not deleted."

      redirect_to blog_path(@comment)
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."

      redirect_to login_path
    end
  end
end
