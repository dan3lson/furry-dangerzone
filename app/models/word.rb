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

  def self.define(name)
    if name
      word = find_by(name: name)
      if word.nil?
        macmillan_word = MacmillanDictionary.define(word)
        if macmillan_word.nil?
          "Yikes! We couldn\'t find '#{name}'. Please search again!"
        else
          word =
            Word.find_or_create_by(
              name: @query,
              phonetic_spelling: macmillan_word.phonetic_spelling,
              part_of_speech: macmillan_word.part_of_speech,
              definition: macmillan_word.definition,
              example_sentence: macmillan_word.example_sentence
            )
          [word]
        end
      else
        [word]
      end
    end
  end

  def self.has_records?
    self.count > 0
  end

  def self.random
    self.all.sample.name
  end
end
