class GameMailer < ApplicationMailer
	def new_freestyle(free, user, game)
		@free = free
		@user = user
		@game = game
		mail to: "danelson.rosa@leksi.education",
				 subject: "New #{@game.name} Freestyle Response from #{@user.username}"
	end
end
