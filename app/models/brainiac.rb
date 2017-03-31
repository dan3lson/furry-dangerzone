class Brainiac < User
	# Teacher also needs this
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
	                  format: { with: VALID_EMAIL_REGEX },
	                  uniqueness: { case_sensitive: false },
	                  unless: :is_student?
	before_create { self.email = email.downcase }
end
