class Word < ActiveRecord::Base
  include Nokogiri
  require 'open-uri'

  default_scope -> { order('words.name ASC') }

  has_many :examples, dependent: :destroy
  has_many :example_non_examples, dependent: :destroy
  has_many :meaning_alts, dependent: :destroy
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
    where(name: name)
  end

  # TODO: Create test
  def self.word_exists?(name)
    !search(name).empty?
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
  def has_meaning_alts?
    meaning_alts.any?
  end

  # TODO: Create test
  def has_ex_non_exs?
    example_non_examples.any?
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

  def self.seventh_grade
    [
      "abate",
      "abnormal",
      "abode",
      "abrupt",
      "accelerate",
      "acclaim",
      "acknowledge",
      "acquire",
      "acrid",
      "addict",
      "adjacent",
      "admonish",
      "affliction",
      "agitate",
      "ajar",
      "akin",
      "allege",
      "annihilate",
      "anonymous",
      "antagonize",
      "apathy",
      "arbitrate",
      "aspire",
      "astute",
      "authentic",
      "avert",
      "bellow",
      "beseech",
      "catastrophe",
      "cater",
      "chorus",
      "citrus",
      "clamber",
      "climax",
      "compromise",
      "concur",
      "confront",
      "congested",
      "conjure",
      "consult",
      "corrupt",
      "counterfeit",
      "covet",
      "customary",
      "debut",
      "deceased",
      "dependent",
      "despondent",
      "detach",
      "devour",
      "dishearten",
      "dismal",
      "dismantle",
      "distraught",
      "downright",
      "exuberant",
      "flaw",
      "fruitless",
      "gaudy",
      "geography",
      "gratify",
      "gravity",
      "grim",
      "grimy",
      "grueling",
      "gruesome",
      "haggle",
      "headlong",
      "hilarious",
      "homage",
      "homicide",
      "hospitable",
      "hurtle",
      "hybrid",
      "illiterate",
      "impede",
      "implore",
      "incident",
      "incredulous",
      "infamous",
      "lurk",
      "maternal",
      "maul",
      "melancholy",
      "mellow",
      "momentum",
      "mortify",
      "mull",
      "murky",
      "narrative",
      "negligent",
      "nimble",
      "nomadic",
      "noteworthy",
      "notify",
      "notorious",
      "nurture",
      "obnoxious",
      "oration",
      "orthodox",
      "overwhelm",
      "pamper",
      "patronize",
      "peevish",
      "pelt",
      "pending",
      "perceived",
      "perjury",
      "permanent",
      "persist",
      "perturb",
      "pique",
      "pluck",
      "poised",
      "ponder",
      "potential",
      "predatory",
      "presume",
      "preview",
      "prior",
      "prowess",
      "radiant",
      "random",
      "rant",
      "recede",
      "reprimand",
      "resume",
      "retort",
      "robust",
      "rupture",
      "saga",
      "sequel",
      "sham",
      "shirk",
      "simultaneously",
      "snare",
      "species",
      "status",
      "stodgy",
      "substantial",
      "subtle",
      "sullen",
      "supervise",
      "tamper",
      "throb",
      "toxic",
      "tragedy",
      "trickle",
      "trivial",
      "uncertainty",
      "unscathed",
      "upright",
      "urgent",
      "utmost",
      "vengeance",
      "vicious",
      "vindictive",
      "vista",
      "vocation",
      "void",
      "wary",
      "whim",
      "wince",
      "wrath",
      "yearn"
    ]
  end

  def self.seventh_grade_words
    where(name: Word.seventh_grade).limit(30)
  end

  # TODO Remove once project is complete
  def self.seventh_grade_grouped
    where(name: Word.seventh_grade.take(60)).group_by { |w| w.name }
  end

  def self.pilot_for_seventh_grade
    Word.find([
      3254,
      3268,
      3285,
      3263,
      3292,
      3307,
      3317,
      3322,
      3333,
      304,
      3351,
      3357,
      3360,
      3369,
      3377,
      3301,
      2299,
      3384,
      3388,
      3250,
      3394,
      3396,
      3343,
      3346,
      3679,
      3251,
      3691,
      3683,
      401,
      3397,
      2935,
      1898,
      3257,
      3267,
      3270,
      3278,
      3308,
      3305,
      3314,
      2615,
      3338,
      3391,
      3680,
      3290,
      3345,
      3354,
      3368,
      3371,
      3347,
      3358,
      3376,
      3380,
      3386,
      3243,
      3274,
      3310,
      3372,
      3299,
      3332,
      3383
    ])
  end
end
