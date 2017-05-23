class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  validates :user, presence: true

  scope :latest, -> { order("activities.created_at DESC") }
  scope :last_24_hours, -> (time = "activities.created_at") {
    where("#{time} > ?", 24.hours.ago)
  }
end
