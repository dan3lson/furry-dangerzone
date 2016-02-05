class CommentsController < ApplicationController
  layout "application_guest"
  
  def index
    @comments = Comment.all
  end

  def new
    @blog_post = BlogPost.find_by_slug(params[:blog_post_id])
    @comment = Comment.new
  end

  def create
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = Comment.new(comment_params)
    @comment.blog_post = @blog_post
    @comment.user = current_user if logged_in?

    if @comment.save
      flash[:success] = "Thanks for your comment!"

      redirect_to blog_post_path(@blog_post)
    else
      render "blog_posts/show"
    end
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

  def comment_params
    params.require(:comment).permit(:description)
  end
end
