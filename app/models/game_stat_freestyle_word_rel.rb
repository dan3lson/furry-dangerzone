class GameStatFreestyleWordRel < ActiveRecord::Base
  belongs_to :game_stat
  belongs_to :freestyle_word_rel

  validates :game_stat, presence: true
  validates :freestyle_word_rel, presence: true
end
