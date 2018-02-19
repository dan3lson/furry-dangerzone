class UserWord < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :word
  has_many :game_stats, dependent: :destroy
  has_many :freestyles, dependent: :destroy

  validates :user, presence: true
  validates :word, presence: true

  scope :alphabetical, -> { joins(:word).order("LOWER(words.name)") }

  # TODO: Create test
  def self.object(user, word)
    find_by(user: user, word: word)
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
