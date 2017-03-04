class GameStat < ActiveRecord::Base
  belongs_to :user_word
  belongs_to :game
  has_one :game_stat_freestyle, dependent: :destroy
  has_one :freestyle, through: :game_stat_freestyle

  validates :user_word, presence: true
  validates :game, presence: true

  def self.universal(user_word, game, time_started, time_ended)
    GameStat.new(
      user_word: user_word,
      game: game,
      time_started: time_started,
      time_ended: time_ended
    )
  end
end
