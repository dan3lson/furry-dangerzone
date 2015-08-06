class GameLevel < ActiveRecord::Base
  default_scope -> { order('game_levels.level_id ASC') }

  belongs_to :game
  belongs_to :level
  has_many :user_word_game_levels
  has_many :user_words, through: :user_word_game_levels

  validates :game, presence: true
  validates :level, presence: true

  def self.fundamentals
    all.map { |gl| gl if gl.game.name == "Fundamentals" }.compact
  end

  def self.create_fundamentals_for(user_word)
    fundamentals.each do |f|
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: f
      )
    end
  end
end
