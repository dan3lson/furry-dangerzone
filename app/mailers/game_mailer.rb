class GameMailer < ApplicationMailer
	def new_freestyle(free, user, game)
		@free = free
		@user = user
		@game = game
		mail to: "danelson@leksi.education",
				 subject: "New Freestyle Response from #{@user.username}"
	end
end
