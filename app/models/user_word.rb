class UserWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  has_many :user_word_game_levels, dependent: :destroy
  has_many :game_levels, through: :user_word_game_levels

  validates :user, presence: true
  validates :word, presence: true

  def current_game
    game_ids = self.game_levels.pluck(:game_id).uniq

    if game_ids.count == 1
      "one"
    elsif game_ids.count == 2
      "two"
    elsif game_ids.count == 3
      "three"
    else
      nil
    end
  end

  def completed_game_one?
    self.user_word_game_levels.pluck(:status).take(8).uniq.count == 1
  end

  def game_one_in_progress?
    self.user_word_game_levels.pluck(:status).take(8).uniq.count > 1
  end
end
