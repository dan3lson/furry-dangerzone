class GameStat < ActiveRecord::Base
  belongs_to :user_word
  belongs_to :game

  validates :user_word, presence: true
  validates :game, presence: true
  validates :num_played, presence: true
  validates :num_jeop_won, presence: true
  validates :num_jeop_lost, presence: true

  def self.universal(u_w, g, t_s, t_e)
    GameStat.new(
      user_word: u_w,
      game: g,
      time_started: t_s,
      time_ended: t_e
    )
  end
end
