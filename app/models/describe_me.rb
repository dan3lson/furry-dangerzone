class DescribeMe < ActiveRecord::Base
  belongs_to :word
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :freestyle_desc_mes, dependent: :destroy
  has_many :freestyles, through: :freestyle_desc_mes
  has_many :game_stat_freestyle_desc_mes, dependent: :destroy
  has_many :game_stats, through: :game_stat_freestyle_desc_mes

  validates :text, presence: true
  validates :word, presence: true
  validates :creator, presence: true
end
