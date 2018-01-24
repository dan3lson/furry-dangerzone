class Admin::AdminsController < BaseAdminController
	def home
	end
	
	def stats
		@gs = GetStartedStat.find(1)
	end
end
