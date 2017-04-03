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



  ###########################
  #
  #
  #
  #  EXPLORE WORDS BY GRADES
  #
  #
  #
  ###########################

  def self.first_grade
    ids = [
      5644, 5648, 5755, 5761, 5764, 5661, 5770, 5672, 5773, 5789, 5690,
      5792, 5710, 5796, 5800, 5712, 5807, 5718, 5720, 5740, 5751, 5811, 5813,
      5820, 5826, 5827, 5830, 5831, 5837, 5841, 5844, 5845, 5848, 5849, 5860,
      5862, 5870, 5872, 5875, 5877, 5881, 5887, 5894, 5896, 5898, 5899, 5902,
      5909, 5912, 5914, 5940, 5949, 5953, 5956, 5969, 5975, 5980, 5983, 5989,
      5991, 5995, 6005, 6008, 6014, 6016, 6019, 6021, 6026, 6040, 6053, 6060,
      6064, 6070, 6082, 6091
    ]
    Word.find(ids)
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

  def self.fifth_grade_word_names
    [
    	"abolish",
    	"dedicate",
    	"absurd",
    	"deprive",
    	"abuse",
    	"detect",
    	"access",
    	"dictate",
    	"accomplish",
    	"document",
    	"achievement",
    	"duplicate",
    	"aggressive",
    	"alternate",
    	"edible",
    	"altitude",
    	"endanger",
    	"antagonist",
    	"escalate",
    	"antonym",
    	"evade",
    	"anxious",
    	"exasperate",
    	"apparent",
    	"excavate",
    	"approximate",
    	"exert",
    	"aroma",
    	"exhibit",
    	"assume",
    	"exult",
    	"astound",
    	"available",
    	"feeble",
    	"avalanche",
    	"frigid",
    	"banquet",
    	"gigantic",
    	"beverage",
    	"gorge",
    	"bland",
    	"guardian",
    	"blizzard",
    	"budge",
    	"hazy",
    	"bungle",
    	"hearty",
    	"homonym",
    	"cautiously",
    	"challenge",
    	"identical",
    	"character",
    	"illuminate",
    	"combine",
    	"immense",
    	"companion",
    	"impressive",
    	"crave",
    	"independent",
    	"compassion",
    	"industrious",
    	"compensate",
    	"intense",
    	"comply",
    	"intercept",
    	"compose",
    	"concept",
    	"jubilation",
    	"confident",
    	"convert",
    	"kin",
    	"course",
    	"courteous",
    	"luxurious",
    	"debate",
    	"major",
    	"decline",
    	"miniature",
    	"minor",
    	"mischief",
    	"monarch",
    	"moral",
    	"myth",
    	"narrator",
    	"navigate",
    	"negative",
    	"nonchalant",
    	"numerous",
    	"oasis",
    	"obsolete",
    	"occasion",
    	"overthrow",
    	"pardon",
    	"pasture",
    	"pedestrian",
    	"perish",
    	"petrify",
    	"portable",
    	"prefix",
    	"preserve",
    	"protagonist",
    	"provide",
    	"purchase",
    	"realistic",
    	"reassure",
    	"reign",
    	"reliable",
    	"require",
    	"resemble",
    	"retain",
    	"retire",
    	"revert",
    	"route",
    	"saunter",
    	"seldom",
    	"senseless",
    	"sever",
    	"slither",
    	"sluggish",
    	"soar",
    	"solitary",
    	"solo",
    	"sparse",
    	"spurt",
    	"strategy",
    	"suffix",
    	"suffocate",
    	"summit",
    	"suspend",
    	"synonym",
    	"talon",
    	"taunt",
    	"thrifty",
    	"translate",
    	"tropical",
    	"visible",
    	"visual",
    	"vivid",
    	"wilderness",
    	"withdraw"
    ]
  end

  def self.fifth_grade
    ids = [6211, 6212, 6220, 6221, 6224, 5224, 3912, 6225, 6234, 6235, 6238,
       6240, 6249, 6259, 6263, 6264, 6270, 6273, 6285, 6298, 6300, 6303, 6305,
       6307, 6308, 6312, 6318, 6320, 6324, 6327, 6328, 6329, 6332, 4360, 6338,
       6341, 6354, 6357, 6359, 6362, 6363, 6364, 6367, 6379, 6380, 6381, 6382,
       6386, 6390, 6392, 6393, 6396, 6401, 6404, 6408, 6409, 6413, 6424, 6426,
       6431, 6434, 6435, 6439, 6440, 6443, 6449, 6456, 6457, 6464, 6468, 6474,
       6476, 6478, 6481, 6483]
    Word.find(ids)
  end

  def self.sixth_grade
    ids = [
      5050, 5057, 5065, 5067, 5071, 5073, 5074, 5077, 5082, 5083, 5085,
      5092, 5101, 5112, 5113, 5115, 5118, 5123, 5124, 5129, 5131, 5133, 5134,
      5136, 5140, 5144, 5145, 5153, 5159, 5171, 5178, 5180, 5182, 5187, 5199,
      5202, 5205, 5209, 5211, 5217, 5218, 5223, 5226, 5227, 5232, 5235, 5237,
      5241, 5242, 5248, 5252, 5254, 5262, 5263, 5266, 5267, 5268, 5271, 5273,
      5276, 5280, 5283, 5291, 5297, 5298, 5299, 5301, 5302, 5305, 5306, 5308,
      5309, 5311, 5314, 5316
    ]
    Word.find(ids)
  end

  def self.seventh_grade
    ids = [
      3243, 3262, 3268, 3281, 3292, 3306, 3333, 3346, 3351, 3369, 3372, 3377,
      3382, 3676, 3251, 3266, 3275, 3299, 3345, 3358, 3362, 3374, 3383, 3681,
      3693, 3392, 3396, 3400, 3403, 3412, 3413, 3417, 3422, 3424, 3440, 3441,
      3445, 3696, 3502, 3506, 3508, 3516, 3519, 3555, 3561, 3576, 3585, 3597,
      3609, 3617, 3641, 3652, 3654, 3664, 3667, 3470, 3507, 3509, 3520, 3527,
      3530, 3546, 3565, 3567, 3583, 3601, 3619, 3621, 3634, 3639, 3644, 3657,
      3660, 3665, 3673
    ]
    Word.find(ids)
  end

  def self.eigth_grade
    ids = [
      5319, 5532, 5536, 5538, 5541, 5543, 5546, 5324, 5327, 5547, 5341, 5348,
      5552, 5556, 5558, 5351, 5352, 5356, 5361, 5560, 5563, 5364, 5366, 5369,
      5564, 5567, 5572, 5388, 5390, 5391, 5574, 5403, 5412, 5415, 5583, 5223,
      5585, 5587, 5590, 5591, 5596, 5431, 5433, 5444, 5451, 5453, 5456, 5597,
      5600, 5471, 5605, 5606, 5481, 5608, 5609, 5610, 5491, 5494, 5498, 5613,
      5615, 5617, 5620, 5500, 5624, 5625, 5501, 5630, 5631, 5633, 5521, 5638,
      5528, 5642, 5642
    ]
    Word.find(ids)
  end
end
