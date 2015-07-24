class User < ActiveRecord::Base
  has_many :user_words, dependent: :destroy
  has_many :words, through: :user_words
  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags
  has_many :user_word_tags, dependent: :destroy
  has_many :word_tags, through: :user_word_tags

  validates :username,
    presence: true,
    uniqueness: true,
    length: { minimum: 3, maximum: 33 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def has_words?
    self.words.any?
  end

  def already_has_word?(word)
    self.words.include?(word)
  end

  def has_tags?
    self.tags.any?
  end

  def already_has_tag?(tag)
    self.tags.include?(tag)
  end
end
