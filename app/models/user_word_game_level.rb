class UserWordGameLevel < ActiveRecord::Base
  belongs_to :user_word
  belongs_to :game_level
  has_many :freestyle_responses

  validates :user_word, presence: true
  validates :game_level, presence: true
  validates :status, presence: true
end
