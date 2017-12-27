class Admin::UsersController < BaseAdminController
	def index
    @filter = params[:filter]
		@user_count = User.count

    if @filter
      if @filter == "latest"
        @users = User.order("created_at DESC").page(params[:page])
			elsif @filter == "num_words"
				@users = User.order("user_words_count DESC")
										 .page(params[:page])
			elsif @filter == "alpha"
				@users = User.order("username ASC")
										 .page(params[:page])
      end
    else
      @users = User.order("created_at DESC").page(params[:page])
    end
  end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "Successfully updated #{@user.username}\'s profile."
      redirect_to admin_users_path
    else
      render :edit
    end
  end

	def destroy
    @user = User.find(params[:id])

    if @user.destroy
      flash[:success] = "Success: account deleted for \'#{@user.username}\'."
      redirect_to admin_users_path
    end
  end

	private

	def user_params
		@user = User.find(params[:id])
		@symbol = @user.is_teacher? ? :teacher : :student
		params.require(@symbol).permit(
			:type,
			:teacher_id,
			:classroom_id,
			:username,
			:password,
			:password_confirmation,
			:first_name,
			:last_name,
			:email
		)
	end
end
