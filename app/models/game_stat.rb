class GameStat < ActiveRecord::Base
  belongs_to :user_word
  belongs_to :game
  has_one :game_stat_example_non_example, dependent: :destroy
  has_one :game_stat_meaning_alt, dependent: :destroy
  has_one :game_stat_freestyle_sent_stem, dependent: :destroy
  has_one :game_stat_freestyle_rel_word, dependent: :destroy
  has_one :game_stat_freestyle_lek_tale, dependent: :destroy

  validates :user_word, presence: true
  validates :game, presence: true

  scope :funds, -> { where(game: (4..9).to_a) }
  scope :jeops, -> { where(game: ([10, 11])) }
  scope :frees, -> { where(game: (12..30).to_a) }
  scope :last_24_hours, -> (time = "updated_at") {
    where("#{time} > ?", 24.hours.ago)
  }

  # TODO Move to GameStats controller
  def self.universal(user_word, game, time_started, time_ended)
    GameStat.new(
      user_word: user_word,
      game: game,
      time_started: time_started,
      time_ended: time_ended
    )
  end
end
