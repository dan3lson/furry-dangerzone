class Word < ActiveRecord::Base
  has_many :user_words, dependent: :destroy
  has_many :users, through: :user_words
  has_many :word_sources, dependent: :destroy
  has_many :sources, through: :word_sources

  before_create { self.name = name.downcase }

  validates :name, presence: true, uniqueness: true
  validates :phonetic_spelling, presence: true
  validates :definition, presence: true
  validates :part_of_speech, presence: true
  validates :example_sentence, presence: true

  default_scope -> { order('words.name ASC') }

  def self.define(word)
    if word
      where("name like ?", "%#{word}%").limit(10)
    end
  end
end
