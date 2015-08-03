class Word < ActiveRecord::Base
  default_scope -> { order('words.name ASC') }

  has_many :user_words, dependent: :destroy
  has_many :users, through: :user_words
  has_many :word_tags, dependent: :destroy
  has_many :tags, through: :word_tags
  has_many :word_synonyms
  has_many :synonyms, through: :word_synonyms

  validates :name, presence: true
  validates :definition, presence: true

  before_create { self.name = name.downcase }

  def self.search(word)
    where(name: word)
  end

  def self.words_are_found?(word)
    !search(word).empty?
  end

  def self.define(name)
    if name
      if words_are_found?(name)
        search(name)
      else
        macmillan_search = MacmillanDictionary.define(name)
        if macmillan_search.nil?
          "Yikes! We couldn\'t find '#{name}'. Please search again!"
        else
          words = []
          macmillan_search.each do |entry|
            word = Word.new(
              name: name,
              phonetic_spelling: entry.phonetic_spelling,
              part_of_speech: entry.part_of_speech,
              definition: entry.definition,
              example_sentence: entry.example_sentence
              )
            if word.save
              words << word
            else
              "Yikes! Something went wrong :'( Please search again!"
            end
          end
          words
        end
      end
    end
  end

  def self.has_records?
    count > 0
  end

  def self.random
    all.sample.name
  end

  def has_synonyms?
    synonyms.any?
  end

  def self.untagged_for(user)
    words_with_tags = user.word_tags.pluck(
      :word_id).map { |word_id| Word.find(word_id) }
    user.words - words_with_tags
  end
end
