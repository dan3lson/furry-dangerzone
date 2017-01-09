class Admin::UsersController < BaseAdminController
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
end
