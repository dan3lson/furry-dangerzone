class LandingPage < ActiveRecord::Base
  default_scope -> { order('landing_page.created_at DESC') }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :target, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_nil: true,
                    uniqueness: { case_sensitive: false }

  before_create { self.email = email.downcase }
end
