class GameStat < ActiveRecord::Base
  belongs_to :user_word
  belongs_to :game

  validates :user_word, presence: true
  validates :game, presence: true
  validates :num_played, presence: true
end
