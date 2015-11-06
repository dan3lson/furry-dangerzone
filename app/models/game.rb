class Game < ActiveRecord::Base
  has_many :game_stats, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
