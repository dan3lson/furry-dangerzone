class UserWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  has_many :user_word_game_levels, dependent: :destroy
  has_many :game_levels, through: :user_word_game_levels

  validates :user, presence: true
  validates :word, presence: true

  def current_game
    game_ids = self.game_levels.pluck(:game_id).uniq
    game_name = Game.find(game_ids.first).name unless game_ids.count > 1

    if game_name == "Fundamentals"
      "one"
    elsif game_name == "Jeopardy"
      "two"
    elsif game_name == "Freestyle"
      "three"
    else
      nil
    end
  end
end
