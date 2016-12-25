class Word < ActiveRecord::Base
  include Nokogiri
  require 'open-uri'

  default_scope -> { order('words.name ASC') }

  has_many :examples
  has_many :meaning_alts
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

  # TODO: Create test
  def self.search(name)
    where(name: name).limit(3)
  end

  # TODO: Create test
  def self.word_exists?(name)
    !search(name).empty?
  end

  # TODO: Create test
  def self.myLeksi_words(user, name)
    user.words.where(name: name)
  end

  # TODO: Create test
  def self.found_in_myLeksi?(user, name)
    myLeksi_words(user, name).any?
  end

  def self.define(name)
    if name
      if word_exists?(name)
        search(name)
      else
        blank_msg = "Type a word and then we'll try to find it."

        return blank_msg if name.blank?

        words_api_search = WordsApi.define(name)

        if words_api_search.nil?
          "Yikes, we couldn\'t find '#{name}'. Please search again."
        else
          words = []

          words_api_search.each do |w|
            word = Word.new(
                name: name,
                phonetic_spelling: w.phonetic_spelling,
                part_of_speech: w.part_of_speech,
                definition: w.definition
              )

            if w.examples
              if w.examples.count > 1
                text = w.examples.join("***")
              else
                text = w.examples.first
              end

              example = Example.new(text: text, word: word)
              word.examples << example
            end

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
    find(Word.pluck(:id).sample(num))
  end

  # TODO: Create test
  def self.random_excluding(num, word_id)
    where.not(id: word_id).random(num)
  end

  # TODO: Create test
  def has_examples?
    examples.any?
  end

  # TODO: Create test
  def has_synonyms?
    WordSynonym.where(word: self).any?
  end

  # TODO: Create test
  def has_antonyms?
    WordAntonym.where(word: self).any?
  end

  # TODO: Create test
  def doesnt_have_any_syn_or_ant?
    !has_synonyms? && !has_antonyms?
  end

  # TODO: Create test
  def self.untagged_for(user)
    words_with_tags = user.word_tags.pluck(
      :word_id
    ).map { |word_id| Word.find(word_id) }

    user.words - words_with_tags
  end

  # HEROKU UPDATES

  # Update phonetic spellings for all words
  def self.update_phonetic_spellings(limit, offset)
    url = "http://wwww.thefreedictionary.com"

    limit(limit).offset(offset).each do |word|
      page = Nokogiri::HTML(open("#{url}/#{word.name}"))
      phonetic_spellings = page.xpath(
        "//*[@id='Definition']/section[3]/h2"
      )

      next unless phonetic_spellings.any?

      phonetic_spelling = phonetic_spellings.first.text

      if phonetic_spelling =~ /\d/
        phonetic_spelling = phonetic_spelling.gsub(/\d/, ";").split(";").first
      end

      word.phonetic_spelling = phonetic_spelling

      if word.save
        puts "#{word.name} succesfully updated"
      else
        puts "ERROR with #{word.name}"
      end
    end
  end

  def self.p_s(name, p_s)
    where(name: name).update_all(phonetic_spelling: p_s)
  end
end
