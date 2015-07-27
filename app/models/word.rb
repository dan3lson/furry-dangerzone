class Word < ActiveRecord::Base
  has_many :user_words, dependent: :destroy
  has_many :users, through: :user_words
  has_many :word_tags, dependent: :destroy
  has_many :tags, through: :word_tags

  before_create { self.name = name.downcase }

  validates :name, presence: true, uniqueness: true
  validates :definition, presence: true
  validates :part_of_speech, presence: true

  default_scope -> { order('words.name ASC') }

  def self.define(name)
    if name
      word = find_by(name: name)
      if word.nil?
        macmillan_word = MacmillanDictionary.define(name)
        if macmillan_word.nil?
          "Yikes! We couldn\'t find '#{name}'. Please search again!"
        else
          word =
            Word.find_or_create_by!(
              name: name,
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
