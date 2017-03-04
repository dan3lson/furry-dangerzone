class GameStatFreestyle < ActiveRecord::Base
  belongs_to :game_stat
  belongs_to :freestyle

  validates :game_stat, presence: true
  validates :freestyle_response, presence: true
end
