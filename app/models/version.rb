class Version < ActiveRecord::Base
  # has_many :reviews, dependent: :destroy

  validates :number, presence: true, uniqueness: true

  default_scope -> { order('versions.number ASC') }

  def has_reviews?
    self.reviews.any?
  end

  def full_name
    "Version #{self.number}"
  end
end
