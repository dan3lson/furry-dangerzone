class MeaningAlt < ActiveRecord::Base
  belongs_to :word
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :game_stat_meaning_alts, dependent: :destroy
  has_many :game_stats, through: :game_stat_meaning_alts

  validates :text, presence: true
  validates :choices, presence: true
  validates :answer, presence: true
  validates :feedback, presence: true
  validates :word, presence: true
  validates :creator, presence: true
end
