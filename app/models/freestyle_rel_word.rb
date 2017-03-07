class FreestyleRelWord < ActiveRecord::Base
  belongs_to :freestyle
  belongs_to :rel_word, class_name: "Word"
  has_one :game_stat_freestyle_rel_word, dependent: :destroy
  has_one :game_stat, through: :game_stat_freestyle_rel_word

  validates :freestyle, presence: true
  validates :rel_word, presence: true
end
