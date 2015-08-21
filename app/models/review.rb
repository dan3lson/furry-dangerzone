class Review < ActiveRecord::Base
  default_scope -> { order('reviews.created_at DESC') }

  belongs_to :user
  belongs_to :version

  validates :rating, presence: true, inclusion: { in: [1, 2, 3, 4, 5] }
  validates :user, presence: true
  validates :version, presence: true

  RATINGS = (1..5).to_a

  def has_description?
    !self.description.blank?
  end
end
