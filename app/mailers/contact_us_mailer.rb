class ContactUsMailer < ApplicationMailer
	def new_message(fields)
		@fields = fields
		mail(
			to: "danelson.rosa@gmail.com",
			subject: "New Online Leksi Message"
		)
	end
end
