class Game < ActiveRecord::Base
  has_many :game_levels
  has_many :levels, through: :game_levels

  validates :name, presence: true
  validates :description, presence: true
end
