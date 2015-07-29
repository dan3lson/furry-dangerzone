class Word < ActiveRecord::Base
  has_many :user_words, dependent: :destroy
  has_many :users, through: :user_words
  has_many :word_tags, dependent: :destroy
  has_many :tags, through: :word_tags

  before_create { self.name = name.downcase }

  validates :name,
    presence: true,
    uniqueness: { scope: :definition }
  validates :definition, presence: true

  default_scope -> { order('words.name ASC') }

  def self.search(word)
    where(name: word)
  end

  def self.word_is_found?(word)
    !search(word).empty?
  end

  def self.define(name)
    if name
      if word_is_found?(name)
        search(name)
      else
        macmillan_word = MacmillanDictionary.define(name)
        if macmillan_word.nil?
          "Yikes! We couldn\'t find '#{name}'. Please search again!"
        else
          word = Word.new(
            name: name,
            phonetic_spelling: macmillan_word.phonetic_spelling,
            part_of_speech: macmillan_word.part_of_speech,
            definition: macmillan_word.definition,
            example_sentence: macmillan_word.example_sentence
            )
          if word.save
            [word]
          else
            "Yikes! Something went wrong :'( Please search again!"
          end
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

  def self.untagged_for(user)
    words_with_tags = user.word_tags.pluck(
      :word_id).map { |word_id| Word.find(word_id) }
    user.words - words_with_tags
  end
end
