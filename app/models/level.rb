class Level < ActiveRecord::Base
  has_many :game_levels
  has_many :games, through: :game_levels

  validates :focus, presence: true
  validates :direction, presence: true
end
