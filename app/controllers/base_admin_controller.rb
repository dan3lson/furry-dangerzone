class BaseAdminController < ApplicationController
	before_action :logged_in_user
  before_action :correct_user
	layout "application_admin"

	private

	def logged_in_user
		unless logged_in?
			flash[:danger] = "Please log in first."
			redirect_to login_url
		end
	end

	def correct_user
		unless current_user.is_admin?
			flash[:danger] = "Access denied."
			redirect_to root_path
		end
	end
end
