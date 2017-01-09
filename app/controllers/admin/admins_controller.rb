class Admin::AdminsController < BaseAdminController
	def stats
		@gs = GetStartedStat.find(1)
		@feedbacks = Feedback.all
	end

	def settings
	end
end
