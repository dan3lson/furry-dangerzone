class User < ActiveRecord::Base
  has_many :user_words
  has_many :words, through: :user_words

  validates :username,
    presence: true,
    uniqueness: true,
    length: { minimum: 3, maximum: 33 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def has_words?
    self.words.any?
  end
end
