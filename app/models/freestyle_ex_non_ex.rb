class FreestyleExNonEx < ActiveRecord::Base
  belongs_to :freestyle
  # has_one :game_stat_freestyle_ex_non_ex, dependent: :destroy
  # has_one :game_stat, through: :game_stat_freestyle_ex_non_ex

  validates :freestyle, presence: true
  validates :kind, presence: true
end
