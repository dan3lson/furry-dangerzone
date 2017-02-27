class GameStat < ActiveRecord::Base
  belongs_to :user_word
  belongs_to :game
  has_many :game_stat_meaning_alts, dependent: :destroy
  has_many :meaning_alts, through: :game_stat_meaning_alts

  validates :user_word, presence: true
  validates :game, presence: true

  def self.universal(u_w, g, t_s, t_e)
    GameStat.new(
      user_word: u_w,
      game: g,
      time_started: t_s,
      time_ended: t_e
    )
  end
end
