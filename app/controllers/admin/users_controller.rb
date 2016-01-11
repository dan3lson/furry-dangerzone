class Admin::UsersController < BaseAdminController
	before_action :logged_in_user
  before_action :correct_user

	def index
    @filter = params[:filter]

    if @filter
      if @filter == "latest"
        @users = User.order("created_at DESC").paginate(:page => params[:page])
      end
    else
      @users = User.order("username ASC").paginate(:page => params[:page])
    end

    @user_count = User.count
  end

	private

	def logged_in_user
		unless logged_in?
			flash[:danger] = "Yikes! Please log in first to do that."

			redirect_to login_url
		end
	end

	def correct_user
		unless current_user.is_admin?
			flash[:danger] = "Yikes! That\'s not something you can do."

			redirect_to root_path
		end
	end
end
