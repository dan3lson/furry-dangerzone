class UserWord < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :word
  has_many :game_stats, dependent: :destroy
  has_many :freestyle_responses, dependent: :destroy

  validates :games_completed, presence: true
  validates :user, presence: true
  validates :word, presence: true

  scope :alphabetical, -> { joins(:word).order("words.name") }
  scope :latest, -> { order("user_words.created_at DESC") }
  scope :completed_fundamentals, -> { where("games_completed > ?", 5) }
  scope :incomplete_fundamentals, -> { where("games_completed < ?", 6) }
  scope :completed_jeopardys, -> { where("games_completed > ?", 7) }
  scope :incomplete_jeopardys, -> { where(games_completed: [6, 7]) }
  scope :completed_freestyles, -> { where("games_completed > ?", 11) }
  scope :incomplete_freestyles, -> { where(games_completed: [8, 9, 10, 11]) }

  # TODO: Create test
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

  # TODO: Create test
  def self.object(user, word)
    find_by(user: user, word: word)
  end

  # TODO: Update test
  def self.update_games_completed(user, word, num)
    user_word = UserWord.object(user, word)
    user_word.games_completed = num

    if user_word.save
      "Success: UW #{user_word.id}\'s games_completed now at #{num}."
    else
      "ERROR: UW #{user_word.id}\'s Fundamentals stat not updated to #{num}."
    end
  end

  # TODO: Update test!
  def current_game
    games_completed + 1
  end

  def game
    word = self.word
    case current_game
    when 1
      "Speed Speller"
    when 2
      "Jumbled Spelling"
    when 3
      if word.has_pronunciation?
        "Say It Right"
      elsif word.has_meaning_alts?
        "Decisions, Decisions"
      elsif word.has_ex_non_exs?
        "Examples/Non-Examples"
      elsif word.has_syns_or_ants?
        "Syns vs. Ants"
      else
        "Jeopardy"
      end
    when 4
      if word.has_meaning_alts?
        "Decisions, Decisions"
      elsif word.has_ex_non_exs?
        "Examples/Non-Examples"
      elsif word.has_syns_or_ants?
        "Syns vs. Ants"
      else
        "Jeopardy"
      end
    when 5
      if word.has_ex_non_exs?
        "Examples/Non-Examples"
      elsif word.has_syns_or_ants?
        "Syns vs. Ants"
      else
        "Jeopardy"
      end
    when 6
      if word.has_syns_or_ants?
        "Syns vs. Ants"
      else
        "Jeopardy"
      end
    when 7
      "Jeopardy"
    when 8
      "Match \'Em All"
    when 9
      if word.has_sent_stems?
        "Sentence Stems"
      else
        "Word Relationships"
      end
    when 10
      "Word Relationships"
    when 11
      "Leksi Tale"
    when 12
      if word.has_describe_mes?
        "Describe Me, Describe Me Not"
      else
        "Practice"
      end
    when 13
      "In My Life"
    else
      "Not sure: UW ID: #{self.id} #{self.word.name} #{self.user.username}"
    end
  end

  # TODO: Update test
  def fundamental_completed?
    current_game > 6
  end

  # TODO: Update test
  def fundamental_not_completed?
    current_game <= 6
  end

  # TODO: Update test
  def jeopardy_completed?
    current_game > 8
  end

  # TODO: Update test
  def jeopardy_not_completed?
    current_game == 7 || current_game == 8
  end

  # TODO: Update test
  def freestyle_completed?
    current_game > 12
  end

  # TODO: Update test
  def freestyle_not_completed?
    current_game > 8 && current_game < 13
  end

  # TODO: Create test
  def _to_date(date)
    date.to_date
  end

  # TODO: Create test. Probably shouldn't be here in this class.
  def yesterday
    Date.yesterday
  end

  # TODO: Update test. Probably shouldn't be here in this class.
  def today
    Date.today
  end

  # TODO: Update test
  def fundamental_completed_yesterday?
    _to_date(updated_at) == yesterday && fundamental_completed?
  end

  # TODO: Update test
  def jeopardy_completed_yesterday?
    _to_date(updated_at) == yesterday && jeopardy_completed?
  end

  # TODO: Update test
  def freestyle_completed_yesterday?
    _to_date(updated_at) == yesterday && freestyle_completed?
  end

  # TODO: Update test
  def freestyle_completed_today?
    _to_date(updated_at) == today && freestyle_completed?
  end

  # TODO: Create test
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
