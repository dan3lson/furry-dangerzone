class Tag < ActiveRecord::Base
  has_many :user_tags, dependent: :destroy
  has_many :teachers, through: :user_tags, class_name: "Teacher", foreign_key: "user_id"

  validates :name, presence: true, uniqueness: true

  scope :alphabetical, -> { order("LOWER(tags.name) ASC") }
end
