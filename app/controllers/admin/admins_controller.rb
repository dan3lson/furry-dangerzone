class Admin::AdminsController < BaseAdminController
	def stats
		@gs = GetStartedStat.find(1)
	end
end
