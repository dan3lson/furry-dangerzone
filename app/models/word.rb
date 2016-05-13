class Word < ActiveRecord::Base
  include Nokogiri
  require 'open-uri'

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

  # Update phonetic spellings for all words
  # def self.update_phonetic_spelling_from_free_dictionary
  #   url = "http://wwww.thefreedictionary.com"
  #
  #   all.each do |word|
  #     page = Nokogiri::HTML(open("#{url}/#{word.name}"))
  #     phonetic_spellings = page.xpath(
  #       "//*[@id='Definition']/section[3]/h2"
  #     )
  #
  #     next unless phonetic_spellings.any?
  #
  #     phonetic_spelling = phonetic_spellings.first.text
  #
  #     if phonetic_spelling =~ /\d/
  #       phonetic_spelling = phonetic_spelling.gsub(/\d/, ";").split(";").first
  #     end
  #
  #     word.phonetic_spelling = phonetic_spelling
  #
  #     if word.save
  #       puts "#{word.name} succesfully updated"
  #     else
  #       puts "ERROR with #{word.name}"
  #     end
  #   end
  # end
end
