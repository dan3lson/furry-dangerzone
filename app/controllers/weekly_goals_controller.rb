class WeeklyGoalsController < ApplicationController
	def update
		@new_weekly_goal = params[:weekly_goal]

		current_user.goal = @new_weekly_goal

		if current_user.save
			flash[:success] = "Success!"

			redirect_to root_path
		else
			msg = "Yikes! Your Weekly Goal was not changed successfully. "
			msg_2 = "Please try again."

			flash[:error] = msg << msg_2

			redirect_to weekly_goal_path
		end
	end
end
