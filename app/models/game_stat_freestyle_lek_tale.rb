class GameStatFreestyleLekTale < ActiveRecord::Base
  belongs_to :game_stat
  belongs_to :freestyle_lek_tale

  validates :game_stat, presence: true
  validates :freestyle_lek_tale, presence: true
end
