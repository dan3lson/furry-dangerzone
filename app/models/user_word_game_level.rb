class UserWordGameLevel < ActiveRecord::Base
  belongs_to :user_word
  belongs_to :game_level

  validates :user_word, presence: true
  validates :game_level, presence: true
  validates :status, presence: true
end
