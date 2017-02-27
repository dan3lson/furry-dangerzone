class GameStatMeaningAlt < ActiveRecord::Base
  belongs_to :game_stat
  belongs_to :meaning_alt

  validates :game_stat, presence: true
  validates :meaning_alt, presence: true
end
