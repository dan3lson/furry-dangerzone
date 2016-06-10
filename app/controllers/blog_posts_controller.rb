class BlogPostsController < ApplicationController
  before_action :admin_only, except: [
    :index,
    :show,
    :all_about_leksi_part_1,
    :all_about_leksi_part_2
  ]

  layout "application_guest", except: [:edit, :new]

  def danelson_rosa
  end

  def index
    @blog_posts = BlogPost.all
  end

  def show
    @blog_post = BlogPost.find_by_slug(params[:id])
    @blog_post_comments = @blog_post.comments if @blog_post.comments.any?
    @comment = Comment.new
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)

    if @blog_post.save
      flash[:success] = "Post successfully created."

      redirect_to blog_posts_path
    else
      render :new
    end
  end

  def edit
    @blog_post = BlogPost.find_by_slug(params[:id])
  end

  def update
    @blog_post = BlogPost.find_by_slug(params[:id])

    if @blog_post.update(blog_post_params)
      flash[:success] = "Changes successfully made."

      redirect_to @blog_post
    else
      flash[:danger] = "Changes not successfully made."

      redirect_to "/blog_posts/#{@blog_post.slug}"
    end
  end

  def destroy
    @blog_post = BlogPost.find_by_slug(params[:id])

    if @blog_post.destroy
      flash[:success] = "Post deleted."
    else
      flash[:danger] = "Yikes! Something went wrong. Please try again."
    end

    redirect_to blog_posts_path
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :icon, :slug)
  end

  def admin_only
    unless logged_in? && current_user.is_admin?
      flash[:danger] = "Yikes! Admins only ;)"

      redirect_to blog_posts_path
    end
  end
end
