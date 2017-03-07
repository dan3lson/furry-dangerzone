class FreestyleWordRel < ActiveRecord::Base
  belongs_to :freestyle
  belongs_to :rel_word, class_name: "Word"
  has_one :game_stat_freestyle_word_rel, dependent: :destroy
  has_one :game_stat, through: :game_stat_freestyle_word_rel

  validates :freestyle, presence: true
  validates :rel_word, presence: true
end