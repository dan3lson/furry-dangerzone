class FreestyleResponse < ActiveRecord::Base
  belongs_to :user_word_game_level

  validates :input, presence: true
  validates :user_word_game_level, presence: true
end
