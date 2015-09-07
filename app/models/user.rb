class User < ActiveRecord::Base
  has_many :user_words, dependent: :destroy
  has_many :words, through: :user_words
  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags
  has_many :user_word_tags, dependent: :destroy
  has_many :word_tags, through: :user_word_tags
  has_many :reviews

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 3, maximum: 33 }
  validates :points, presence: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  before_create { self.username = username.downcase }

  def has_words?
    self.words.any?
  end

  def already_has_word?(word)
    self.words.include?(word)
  end

  def has_tags?
    self.tags.any?
  end

  def has_user_word_tags?
    self.user_word_tags.any?
  end

  def already_has_tag?(tag)
    self.tags.include?(tag)
  end

  def is_admin?
    self.role == "admin"
  end

  def has_reached_free_version_limit?
    self.words.count > 9
  end

  def self.top_ten_highest_points
    order("points DESC").take(10)
  end

  def incomplete_fundamentals
    games = []
    self.user_words.each do |uw|
      games << uw unless uw.fundamentals_completed?
    end
    games
  end

  def has_incomplete_fundamentals?
    self.incomplete_fundamentals.any?
  end

  def completed_fundamentals
    games = []
    self.user_words.each do |uw|
      games << uw if uw.fundamentals_completed?
    end
    games
  end

  def has_completed_fundamentals?
    self.completed_fundamentals.any?
  end
end
