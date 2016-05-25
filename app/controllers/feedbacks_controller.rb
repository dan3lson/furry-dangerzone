class FeedbacksController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :destroy]

  def index
    @feedbacks = Feedback.all
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user = current_user

    @feedback.kind = params[:kind]

    if @feedback.save
      msg_2 = "If we have your email address, we\'ll respond within 24 hours."
      flash[:success] = "Thanks for giving feedback! #{msg_2}"

      redirect_to menu_path
    else
      render "feedbacks/new"
    end
  end

  def destroy
    @feedback = Feedback.find(params[:id])

    if @feedback.destroy
      flash[:success] = "Feedback deleted successfully."

      redirect_to feedbacks_path
    else
      flash.now[:danger] = "Feedback not deleted."

      redirect_to feedback_path(@feedback)
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:description)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."

      redirect_to login_path
    end
  end
end
