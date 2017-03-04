class GameStatFreestyleSentStem < ActiveRecord::Base
  belongs_to :game_stat
  belongs_to :freestyle_sent_stem

  validates :game_stat, presence: true
  validates :freestyle_sent_stem, presence: true
end
