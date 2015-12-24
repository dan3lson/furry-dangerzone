class UserWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  has_many :game_stats, dependent: :destroy
  has_many :freestyle_responses, dependent: :destroy

  validates :games_completed, presence: true
  validates :user, presence: true
  validates :word, presence: true

  scope :alphabetical, -> { joins(:word).order("words.name") }

  # not tested
  def self.object(user, word)
    find_by(user: user, word: word)
  end

  def current_game
    if games_completed == 0
      "one"
    elsif games_completed == 1
      "two"
    elsif games_completed == 2
      "three"
    elsif games_completed == 3
      "all-games-completed"
    else
      nil
    end
  end

  def fundamental_completed?
    games_completed > 0
  end

  def fundamental_not_completed?
    current_game == "one" && !fundamental_completed?
  end

  def jeopardy_completed?
    games_completed == 2 || games_completed == 3
  end

  def jeopardy_not_completed?
    current_game == "two" && !jeopardy_completed?
  end

  def freestyle_completed?
    jeopardy_completed? && games_completed == 3
  end

  def freestyle_not_completed?
    current_game == "three" && !freestyle_completed?
  end

  def fundamental_completed_yesterday?
    updated_at.to_date == Date.yesterday && games_completed == 1
  end

  def jeopardy_completed_yesterday?
    updated_at.to_date == Date.yesterday && games_completed == 2
  end

  def freestyle_completed_yesterday?
    updated_at.to_date == Date.yesterday && games_completed == 3
  end

  def freestyle_completed_today?
    updated_at.to_date == Date.today && games_completed == 3
  end

  # not tested
  def self.add_first_four_words(user)
    words = Word.random(4)
    words_successfully_added = 0

    words.each do |w|
      user_word = UserWord.new
      user_word.user = user
      user_word.word = w

      words_successfully_added += 1 if user_word.save
    end

    words_successfully_added
  end
end
