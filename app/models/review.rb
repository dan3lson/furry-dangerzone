class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :version

  validates :rating, presence: true, inclusion: { in: [1, 2, 3, 4, 5] }
  validates :user, presence: true
  validates :version, presence: true

  RATINGS = (1..5).to_a

  default_scope -> { order('reviews.created_at DESC') }

  def has_description?
    !self.description.blank?
  end
end
