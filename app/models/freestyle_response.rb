class FreestyleResponse < ActiveRecord::Base
  default_scope -> { order('freestyle_responses.created_at DESC') }

  belongs_to :user_word_game_level

  validates :input, presence: true
  validates :user_word_game_level, presence: true
end
