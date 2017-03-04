class FreestyleSentStem < ActiveRecord::Base
  belongs_to :freestyle
  belongs_to :sent_stem
  has_one :game_stat_freestyle_sent_stem, dependent: :destroy
  has_one :game_stat, through: :game_stat_freestyle_sent_stem

  validates :freestyle, presence: true
  validates :sent_stem, presence: true
end
