class FreestyleDescMe < ActiveRecord::Base
  belongs_to :freestyle
  belongs_to :describe_me
  has_one :game_stat_freestyle_desc_me, dependent: :destroy
  has_one :game_stat, through: :game_stat_freestyle_desc_me

  validates :freestyle, presence: true
  validates :describe_me, presence: true
end
