class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  validates :user, presence: true

  scope :latest, -> { order("created_at DESC") }
  scope :last_24_hours, -> (time = "created_at") {
    where("#{time} > ?", 24.hours.ago)
  }
end
