class Word < ActiveRecord::Base
  include Nokogiri
  require 'open-uri'

  default_scope -> { order('words.name ASC') }

  has_many :examples, dependent: :destroy
  has_many :example_non_examples, dependent: :destroy
  has_many :meaning_alts, dependent: :destroy
  has_many :sent_stems, dependent: :destroy
  has_many :describe_mes, dependent: :destroy
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
  def num_syllables
    phonetic_spelling.split("·").count if has_syllables?
  end

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
        return "Type a word and then we'll try to find it." if name.blank?
        words_api_search = WordsApi.new(name).define

        if words_api_search.class == String
          words_api_search
        else
          error_message = "Sorry, saving didn\'t work. Please try again."

          words_api_search.map do |new_word|
            new_word.save ? new_word : error_message
          end
        end
      end
    end
  end

  def self.random(num)
    find(Word.pluck(:id).sample(num))
  end

  # TODO: Create test
  def self.random_excluding(num, word_id)
    where.not(id: word_id).random(num)
  end

  # TODO: Create test
  def has_pronunciation?
    url = "https://ssl.gstatic.com/dictionary/static/sounds/de/0"
    src = "#{url}/#{self.name}.mp3"
    response = HTTParty.get(src)
    audio_not_found = response.code == 404
    !audio_not_found
  end

  # TODO: Create test
  def has_examples?
    !examples.blank?
  end

  # TODO: Create test
  def has_meaning_alts?
    !MeaningAlt.where(word: self).blank?
  end

  # TODO: Create test
  def has_ex_non_exs?
    !ExampleNonExample.where(word: self).blank?
  end

  # TODO Create test
  def has_syllables?
    !phonetic_spelling.nil?
  end

  # TODO: Create test
  def has_synonyms?
    !Thesaurus.send("synonyms", name).nil?
    # !WordSynonym.where(word: self).blank?
  end

  # TODO: Create test
  def has_antonyms?
    !Thesaurus.send("antonyms", name).nil?
    # !WordAntonym.where(word: self).blank?
  end

  # TODO: Create test
  def has_syns_or_ants?
    has_synonyms? || has_antonyms?
  end

  # TODO: Create test
  def doesnt_have_any_syn_or_ant?
    !has_synonyms? && !has_antonyms?
  end

  # TODO: Create test
  def has_sent_stems?
    !SentStem.where(word: self).blank?
  end

  # TODO: Create test
  def has_describe_mes?
    !DescribeMe.where(word: self).blank?
  end

  # TODO: Create test
  def self.untagged_for(user)
    words_with_tags = user.word_tags.pluck(:word_id)
                                    .map { |word_id| Word.find(word_id) }
    UserWord.where(user: user).includes(:word).map(&:word) - words_with_tags
  end

  # TODO Create test
  def sample(type)
    if type == "definition"
      send(type).split("***").sample
    elsif type == "examples"
      send(type).first.text.split("***").sample
    end
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
