class ContactUsMailer < ApplicationMailer
	def new_message(fields)
		@fields = fields
		mail to: "danelson@leksi.education", subject: "New Online Leksi Message"
	end
end
