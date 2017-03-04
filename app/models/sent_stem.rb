class SentStem < ActiveRecord::Base
  belongs_to :word
  belongs_to :creator, class_name: "User"
  has_many :freestyle_sent_stems, dependent: :destroy
  has_many :freestyles, through: :freestyle_sent_stems
  has_many :game_stat_freestyle_sent_stems, dependent: :destroy
  has_many :game_stats, through: :game_stat_freestyle_sent_stems

  # validates :name, presence: true
  validates :text, presence: true
  validates :word, presence: true
  validates :creator, presence: true

  before_create { self.text = text.gsub("???", "____________") }
end
