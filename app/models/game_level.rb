class GameLevel < ActiveRecord::Base
  belongs_to :game
  belongs_to :level
  has_many :user_word_game_levels
  has_many :user_words, through: :user_word_game_levels

  validates :game, presence: true
  validates :level, presence: true

  default_scope -> { order('game_levels.level_id ASC') }
end
