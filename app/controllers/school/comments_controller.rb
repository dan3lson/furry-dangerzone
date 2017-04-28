class School::CommentsController < BaseSchoolController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @freestyle = Freestyle.find(params[:freestyle_id])
    @comment = @freestyle.comments.new(comment_params)
    @created = @comment.save

    respond_to do |format|
      format.js
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
    else
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:success] = "That comment was successfully deleted."
      redirect_to :back
    else
      flash[:danger] = "Sorry, something went wrong. Please try again."
      redirect_to :back
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
