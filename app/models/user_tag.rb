class UserTag < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag

  validates :user, presence: true
  validates :tag, presence: true

  scope :alphabetical, -> { joins(:tag).order("LOWER(tags.name)") }
end
