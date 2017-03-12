class GameStatFreestyleDescMe < ActiveRecord::Base
  belongs_to :game_stat
  belongs_to :freestyle_desc_me

  validates :game_stat, presence: true
  validates :freestyle_desc_me, presence: true
end
