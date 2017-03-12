class Freestyle < ActiveRecord::Base
  belongs_to :user_word
  has_one :freestyle_sent_stem, dependent: :destroy
  has_one :sent_stem, through: :freestyle_sent_stem
  has_one :freestyle_lek_tale
  has_one :freestyle_desc_me, dependent: :destroy
  has_one :describe_me, through: :freestyle_desc_me
  has_one :game_stat_freestyle, dependent: :destroy
  has_one :game_stat, through: :game_stat_freestyle
  has_one :game, through: :game_stat

  validates :input, presence: true
  validates :status, presence: true
  validates :user_word, presence: true
end
