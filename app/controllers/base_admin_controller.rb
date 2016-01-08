class BaseAdminController < ApplicationController
	before_action :logged_in_user
  before_action :correct_user

	layout "admin_application"

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
