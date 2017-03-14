class GameMailer < ApplicationMailer
	def new_freestyle(uw)
		mail to: "danelson.rosa@leksi.education",
				 subject: "New Freestyle Response (#{uw.username} | #{uw.word.name})"
	end
end
