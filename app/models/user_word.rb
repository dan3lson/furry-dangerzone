class UserWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  has_many :game_stats, dependent: :destroy
  has_many :freestyle_responses, dependent: :destroy

  validates :games_completed, presence: true
  validates :user, presence: true
  validates :word, presence: true

  scope :alphabetical, -> { joins(:word).order("words.name") }

  # updated -> not tested
  def self.search(user, name)
    if name
      if name.blank?
        "You\'re so silly; type in a word first."
      else
        words = Word.where(name: name)
        user_words = UserWord.object(user, words) unless words.empty?

        if user_words
          user_words.map { |uw| uw.word }
        else
          "You don\'t have that word."
        end
      end
    end
  end

  # not tested
  def self.object(user, word)
    find_by(user: user, word: word)
  end

  # not tested
  def self.mark_fundamentals_completed(user, word)
    user_word = UserWord.find_by(user: user, word: word)
    user_word.games_completed = 1

    if user_word.save
      "Success: UW #{user_word.id}\'s games_completed now at 1."
    else
      "ERROR: UW #{user_word.id}\'s Fundamentals stat not updated."
    end
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
    current_game != "one" && !current_game.nil?
  end

  def fundamental_not_completed?
    current_game == "one"
  end

  def jeopardy_completed?
    current_game == "three" || current_game == "all-games-completed"
  end

  def jeopardy_not_completed?
    current_game == "two"
  end

  def freestyle_completed?
    current_game == "all-games-completed"
  end

  def freestyle_not_completed?
    current_game == "three" && !freestyle_completed?
  end

  # not tested
  def _to_date(date)
    date.to_date
  end

  # not tested
  def yesterday
    Date.yesterday
  end

  # not tested
  def today
    Date.yesterday
  end

  # not tested
  def fundamental_completed_yesterday?
    _to_date(updated_at) == yesterday && current_game == "one"
  end

  # not tested
  def jeopardy_completed_yesterday?
    _to_date(updated_at) == yesterday && current_game == "two"
  end

  # not tested
  def freestyle_completed_yesterday?
    _to_date(updated_at) == yesterday && current_game == "three"
  end

  # not tested
  def freestyle_completed_today?
    _to_date(updated_at) == today && current_game == "three"
  end

  # not tested
  def self.add_words(user, words)
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
