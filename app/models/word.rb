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
  validates :definition, uniqueness: { scope: :name }

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

    begin
      response = HTTParty.get(src)
      audio_not_found = response.code == 404
      !audio_not_found
    rescue => e
      false
    end
  end

  # TODO: Create test
  def has_examples?
    !Example.where(word: self).blank?
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



  ####################
  #
  #
  #
  #   EXPLORE WORDS
  #
  #
  #
  ####################

  def self.find_for(grade_word_names)
    where(name: Word.send(grade_word_names)).limit(250)
  end

  def self.explore(grade_word_names)
    find_for(grade_word_names).group_by(&:name)
    # grade.select("distinct on (name) *")
  end

  def self.second_grade_word_names
    [
    	"accident",
    	"agree",
    	"arrive",
    	"astronomy",
    	"atlas",
    	"attention",
    	"award",
    	"aware",
    	"balance",
    	"banner",
    	"bare",
    	"base",
    	"beach",
    	"besides",
    	"blast",
    	"board",
    	"bounce",
    	"brain",
    	"branch",
    	"brave",
    	"bright",
    	"cage",
    	"calf",
    	"calm",
    	"career",
    	"center",
    	"cheer",
    	"chew",
    	"claw",
    	"clear",
    	"cliff",
    	"club",
    	"collect",
    	"connect",
    	"core",
    	"corner",
    	"couple",
    	"crowd",
    	"curious",
    	"damp",
    	"dangerous",
    	"dash",
    	"dawn",
    	"deep",
    	"demolish",
    	"design",
    	"discard",
    	"dive",
    	"dome",
    	"doubt",
    	"dozen",
    	"earth",
    	"enemy",
    	"evening",
    	"exactly",
    	"excess",
    	"factory",
    	"fair",
    	"famous",
    	"feast",
    	"field",
    	"finally",
    	"flap",
    	"float",
    	"flood",
    	"fold",
    	"fresh",
    	"frighten",
    	"fuel",
    	"gap",
    	"gaze",
    	"gift",
    	"gravity",
    	"greedy",
    	"harm",
    	"herd",
    	"idea",
    	"insect",
    	"instrument",
    	"invent",
    	"island",
    	"leader",
    	"leap",
    	"lizard",
    	"local",
    	"lonely",
    	"luxury",
    	"march",
    	"mention",
    	"motor",
    	"nervous",
    	"net",
    	"nibble",
    	"notice",
    	"ocean",
    	"pack",
    	"pale",
    	"parade",
    	"past",
    	"peak",
    	"planet",
    	"present",
    	"proof",
    	"reflect",
    	"rumor",
    	"safe",
    	"scholar",
    	"seal",
    	"search",
    	"settle",
    	"share",
    	"shelter",
    	"shiver",
    	"shy",
    	"skill",
    	"slight",
    	"smooth",
    	"soil",
    	"stack",
    	"steady",
    	"strand",
    	"stream",
    	"support",
    	"team",
    	"telescope",
    	"tiny",
    	"tower",
    	"travel",
    	"tremble",
    	"universe",
    	"village",
    	"warn",
    	"weak",
    	"wealthy",
    	"whisper",
    	"wise",
    	"wonder",
    	"worry",
    	"yard",
    	"zigzag"
    ]
  end

  def self.second_grade_spe_bee

  end

  def self.fourth_grade_word_names
    [
    	"accurate",
    	"address",
    	"afford",
    	"alert",
    	"analyze",
    	"ancestor",
    	"annual",
    	"apparent",
    	"appropriate",
    	"arena",
    	"arrest",
    	"ascend",
    	"assist",
    	"attempt",
    	"attentive",
    	"attractive",
    	"awkward",
    	"baggage",
    	"basic",
    	"benefit",
    	"blend",
    	"blossom",
    	"burrow",
    	"calculate",
    	"capable",
    	"captivity",
    	"carefree",
    	"century",
    	"chamber",
    	"circular",
    	"coax",
    	"column",
    	"communicate",
    	"competition",
    	"complete",
    	"concentrate",
    	"concern",
    	"conclude",
    	"confuse",
    	"congratulate",
    	"considerable",
    	"content",
    	"contribute",
    	"crafty",
    	"create",
    	"demonstrate",
    	"descend",
    	"desire",
    	"destructive",
    	"develop",
    	"disaster",
    	"disclose",
    	"distract",
    	"distress",
    	"dusk",
    	"eager",
    	"ease",
    	"entertain",
    	"entire",
    	"entrance",
    	"envy",
    	"essential",
    	"extraordinary",
    	"flexible",
    	"focus",
    	"fragile",
    	"frantic",
    	"frequent",
    	"frontier",
    	"furious",
    	"generosity",
    	"hail",
    	"hardship",
    	"heroic",
    	"host",
    	"humble",
    	"impact",
    	"increase",
    	"indicate",
    	"inspire",
    	"instant",
    	"invisible",
    	"jagged",
    	"lack",
    	"limb",
    	"limp",
    	"manufacture",
    	"master",
    	"mature",
    	"meadow",
    	"mistrust",
    	"mock",
    	"modest",
    	"noble",
    	"orchard",
    	"outstanding",
    	"peculiar",
    	"peer",
    	"permit",
    	"plead",
    	"plentiful",
    	"pointless",
    	"portion",
    	"practice",
    	"precious",
    	"prefer",
    	"prepare",
    	"proceed",
    	"queasy",
    	"recent",
    	"recognize",
    	"reduce",
    	"release",
    	"represent",
    	"request",
    	"resist",
    	"response",
    	"reveal",
    	"routine",
    	"severe",
    	"shabby",
    	"shallow",
    	"sole",
    	"source",
    	"sturdy",
    	"surface",
    	"survive",
    	"terror",
    	"threat",
    	"tidy",
    	"tour",
    	"tradition",
    	"tragic",
    	"typical",
    	"vacant",
    	"valiant",
    	"variety",
    	"vast",
    	"venture",
    	"weary"
    ]
  end
end
