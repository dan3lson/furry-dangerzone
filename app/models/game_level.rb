class GameLevel < ActiveRecord::Base
  default_scope -> { order('game_levels.level_id ASC') }

  belongs_to :game
  belongs_to :level
  has_many :user_word_game_levels
  has_many :user_words, through: :user_word_game_levels

  validates :game, presence: true
  validates :level, presence: true

  def self.includes_games(game_name)
    includes(:game).select { |gl| gl.game.name == game_name }
  end

  def self.fundamentals
    includes_games("Fundamentals")
  end

  def self.jeopardys
    includes_games("Jeopardy")
  end

  def self.freestyles
    includes_games("Freestyle")
  end

  def self.create_fundamentals_for(user_word)
    fundamentals.each do |fund| UserWordGameLevel.create!(
        user_word: user_word,
        game_level: fund
      )
    end
  end

  def self.create_jeopardys_for(user_word)
    jeopardys.each do |j| UserWordGameLevel.create!(
        user_word: user_word,
        game_level: j
      )
    end
  end

  def self.create_freestyles_for(user_word)
    freestyles.each do |free| UserWordGameLevel.create!(
        user_word: user_word,
        game_level: free
      )
    end
  end
end
