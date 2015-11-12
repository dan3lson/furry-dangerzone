class WeeklyGoalsController < ApplicationController
	def update
		@new_goal = params[:goal]

		current_user.goal = @new_goal

		if current_user.save
			flash[:success] = "Success!"

			redirect_to root_path
		else
			msg = "Yikes! Your Weekly Goal was not changed successfully. "
			msg_2 = "Pleae try again."

			flash[:error] = msg << msg_2

			redirect_to myGoal_path
		end
	end
end
