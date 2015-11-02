class Feedback < ActiveRecord::Base
  default_scope -> { order('feedbacks.created_at DESC') }

  belongs_to :user

  validates :description, presence: true
  validates :kind, presence: true
  validates :user, presence: true
end
