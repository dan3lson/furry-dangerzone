class GameLevel < ActiveRecord::Base
  default_scope -> { order('game_levels.level_id ASC') }

  belongs_to :game
  belongs_to :level
  has_many :user_word_game_levels
  has_many :user_words, through: :user_word_game_levels

  validates :game, presence: true
  validates :level, presence: true

  def self.fundamentals
    where(game_id: 1)
  end

  def self.jeopardys
    where(game_id: 2)
  end

  def self.freestyles
    where(game_id: 3)
  end

  def self.create_fundamentals_for(user_word)
    fundamentals.each do |f|
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: f
      )
    end
  end

  def self.create_jeopardys_for(user_word)
    jeopardys.each do |j|
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: j
      )
    end
  end

  def self.create_freestyles_for(user_word)
    freestyles.each do |f|
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: f
      )
    end
  end
end
