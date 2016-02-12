class Word < ActiveRecord::Base
  default_scope -> { order('words.name ASC') }

  has_many :user_words, dependent: :destroy
  has_many :users, through: :user_words
  has_many :word_tags, dependent: :destroy
  has_many :tags, through: :word_tags
  has_many :word_synonyms
  has_many :synonyms, through: :word_synonyms
  has_many :word_antonyms
  has_many :antonyms, through: :word_antonyms

  validates :name, presence: true
  validates :definition, presence: true

  before_create { self.name = name.downcase }

  # not tested
  def self.search(word)
    where(name: word).limit(3)
  end

  def self.words_are_found?(word)
    !search(word).empty?
  end

  def self.define(name)
    if name
      if words_are_found?(name)
        search(name)
      else
        return "You\'re so silly; type in a word first." if name.blank?

        free_dictionary_search = FreeDictionary.define(name)

        if free_dictionary_search.nil?
          "Yikes, we couldn\'t find '#{name}'. Please search again."
        else
          words = []

          free_dictionary_search.each do |w|
            word = Word.new(
                name: name,
                phonetic_spelling: w.phonetic_spelling,
                part_of_speech: w.part_of_speech,
                definition: w.definition,
                example_sentence: w.example_sentence
              )

            if word.save
              words << word
            else
              "Yikes, something went wrong :'(. Please search again."
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

  def self.random(num)
    num -= 1
    find(Word.pluck(:id).shuffle[0..num])
  end

  def has_synonyms?
    synonyms.any?
  end

  def has_antonyms?
    antonyms.any?
  end

  def doesnt_have_any_syn_or_ant?
    !has_synonyms? && !has_antonyms?
  end

  def self.untagged_for(user)
    words_with_tags = user.word_tags.pluck(
      :word_id).map { |word_id| Word.find(word_id) }
    user.words - words_with_tags
  end

  # HEROKU UPDATES

  # * Example Sentence *

  # STEP 1
  def self.update_example_sentence_blank_to_nil
    where(example_sentence: "").each do |word|
      word.update_attributes(example_sentence: nil)
    end
  end

  # Step 2
  def self.update_example_sentence_semicolon_to_stars
    where.not(example_sentence: nil).each do |word|
      word.example_sentence = word.example_sentence.gsub(";", "***")
      word.save
    end
  end

  # * Definition *

  # Step 1
  def self.update_definition_semicolon_to_stars
    all.each do |word|
      word.definition = word.definition.gsub(";", "***")
      word.save
    end
  end

  # * Phonetic Spelling *

  # Step 1
  def self.update_phonetic_spelling_blank_to_nil
    where(phonetic_spelling: "").each do |word|
      word.update_attributes(phonetic_spelling: nil)
    end
  end

  # * Part of Speech *

  # Step 1
  def self.update_part_of_speech_blank_to_nil
    where(part_of_speech: "").each do |word|
      word.update_attributes(part_of_speech: nil)
    end
  end

  # Check if any word attribute is blank
  def self.any_blanks?(attribute)
    where("#{attribute} = ?", "").count > 0 ? "yes" : "no"
  end
end
