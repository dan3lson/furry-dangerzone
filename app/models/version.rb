class Version < ActiveRecord::Base
  default_scope -> { order('versions.number DESC') }

  has_many :reviews, dependent: :destroy

  validates :number, presence: true, uniqueness: true
  validates :description, presence: true

  def has_reviews?
    self.reviews.any?
  end

  def number_of_reviews
    self.reviews.count
  end

  def review_ratings
    self.reviews.map { |review| review.rating }
  end

  def average_rating
    self.review_ratings.reduce(:+) / self.number_of_reviews
  end

  def self.total_number_of_reviews
    total_number_of_reviews = []
    self.all.each do |version|
      total_number_of_reviews << version.reviews.count
    end
    total_number_of_reviews.reduce(:+)
  end

  def self.total_average_rating
    total_number_of_ratings = []
    self.all.each do |version|
      total_number_of_ratings << version.review_ratings
    end
    total_number_of_ratings.flatten.reduce(:+) / Version.total_number_of_reviews
  end
end
