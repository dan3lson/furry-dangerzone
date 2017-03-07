class GameStatFreestyleRelWord < ActiveRecord::Base
  belongs_to :game_stat
  belongs_to :freestyle_rel_word

  validates :game_stat, presence: true
  validates :freestyle_rel_word, presence: true
end
