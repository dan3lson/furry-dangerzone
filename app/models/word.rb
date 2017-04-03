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

  def self.second_grade
    ids = [
      4413, 4415, 4416, 4420, 4425, 4427, 4431, 4433, 4435, 4451, 4464, 4472,
      4483, 4489, 4492, 4499, 4502, 4503, 4514, 4525, 4527, 4529, 4541, 4555,
      4559, 4563, 4568, 4585, 4596, 4612, 4622, 4634, 4635, 4640, 4647, 4652,
      4655, 4659, 4665, 4670, 4672, 4681, 4683, 4685, 4687, 4690, 4696, 4701,
      4706, 4711, 4722, 4724, 4746, 4752, 4760, 4763, 4775, 4777, 4786, 4809,
      4819, 4831, 4836, 4846, 4855, 4877, 4880, 4883, 4892, 4894, 4897, 4909,
      4910, 4918
    ]
    Word.find(ids)
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

  def self.fourth_grade
    ids = [
      3903, 3907, 3908, 3912, 3914, 3917, 3921, 3927, 3935, 3944, 3949, 3955,
      3975, 3979, 3992, 3996, 3998, 4004, 4009, 4018, 4039, 4062, 4067, 4072,
      4082, 4087, 4093, 4101, 4107, 4132, 4142, 4144, 4146, 4155, 4158, 4163,
      4168, 4172, 4178, 4181, 4201, 4215, 4226, 4249, 4267, 4278, 4282, 4284,
      4295, 4301, 4921, 4926, 4930, 4933, 4936, 4944, 4954, 4959, 4962, 4965,
      4980, 4985, 4991, 4997, 5003, 5010, 5021, 5025, 5029, 5034, 5038, 5040,
      5042, 5043, 5044
    ]
    Word.find(ids)
  end

  def self.sixth_grade_word_names
    [
    	"abandon",
    	"constant",
    	"abundant",
    	"contaminate",
    	"access",
    	"context",
    	"accommodate",
    	"continuous",
    	"accumulate",
    	"controversy",
    	"adapt",
    	"convenient",
    	"adhere",
    	"cope",
    	"agony",
    	"cordial",
    	"allegiance",
    	"cultivate",
    	"ambition",
    	"cumulative",
    	"ample",
    	"anguish",
    	"declare",
    	"anticipate",
    	"deluge",
    	"anxious",
    	"dense",
    	"apparel",
    	"deplete",
    	"appeal",
    	"deposit",
    	"apprehensive",
    	"designate",
    	"arid",
    	"desperate",
    	"arrogant",
    	"deteriorate",
    	"awe",
    	"dialogue",
    	"diligent",
    	"barren",
    	"diminish",
    	"beacon",
    	"discretion",
    	"beneficial",
    	"dissent",
    	"blunder",
    	"dissolve",
    	"boisterous",
    	"distinct",
    	"boycott",
    	"diversity",
    	"burden",
    	"domestic",
    	"dominate",
    	"campaign",
    	"drastic",
    	"capacity",
    	"duration",
    	"capital",
    	"dwell",
    	"chronological",
    	"civic",
    	"eclipse",
    	"clarity",
    	"economy",
    	"collaborate",
    	"eerie",
    	"collide",
    	"effect",
    	"commend",
    	"efficient",
    	"commentary",
    	"elaborate",
    	"compact",
    	"eligible",
    	"composure",
    	"elude",
    	"concise",
    	"encounter",
    	"consent",
    	"equivalent",
    	"consequence",
    	"erupt",
    	"conserve",
    	"esteem",
    	"conspicuous",
    	"evolve",
    	"exaggerate",
    	"majority",
    	"excel",
    	"makeshift",
    	"exclude",
    	"manipulate",
    	"expanse",
    	"marvel",
    	"exploit",
    	"massive",
    	"extinct",
    	"maximum",
    	"extract",
    	"meager",
    	"mere",
    	"factor",
    	"migration",
    	"former",
    	"mimic",
    	"formulates",
    	"minute",
    	"fuse",
    	"monotonous",
    	"futile",
    	"negotiate",
    	"Generate",
    	"genre",
    	"objective",
    	"obstacle",
    	"habitat",
    	"omniscient",
    	"hazardous",
    	"onset",
    	"hoax",
    	"optimist",
    	"hostile",
    	"originate",
    	"idiom",
    	"painstaking",
    	"ignite",
    	"paraphrase",
    	"immense",
    	"parody",
    	"improvises",
    	"persecute",
    	"inept",
    	"plummet",
    	"inevitable",
    	"possess",
    	"influence",
    	"poverty",
    	"ingenious",
    	"precise",
    	"innovation",
    	"predicament",
    	"intimidate",
    	"predict",
    	"prejudice",
    	"jovial",
    	"preliminary",
    	"primitive",
    	"knack",
    	"priority",
    	"prominent",
    	"leeway",
    	"propel",
    	"prosecute",
    	"legislation",
    	"vow"
    ]
  end

  def self.sixth_grade
    ids = [5198, 5205, 5207, 5213, 5215, 5218, 5224, 5226, 5228, 5237, 5239,
      5240, 5243, 5248, 5249, 5253, 5256, 5258, 5259, 5261, 5263, 5268, 5269,
      5270, 5271, 5274, 5276, 5279, 5283, 5289, 5293, 5305, 5311, 5313, 5325,
      5330, 5335, 5337, 5340, 5349, 5352, 5360, 5365, 5366, 5369, 5372, 5382,
      5392, 5396, 5398, 5402, 5403, 5409, 5413, 5417, 5419, 5422, 5424, 5426,
      5429, 5435, 5438, 5442, 5446, 5454, 5456, 5462, 5463, 5465, 5466, 5468,
      5471, 5474, 5476, 5479]
    Word.find(ids)
  end
end
