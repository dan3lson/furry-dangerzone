class Word < ActiveRecord::Base
  include Nokogiri
  require 'open-uri'

  mount_uploader :photo, WordPhotoUploader

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
  validates :definition, presence: true, uniqueness: { scope: :name }

  before_create { self.name = name.downcase }

  # TODO: Create shell test
  def num_syllables
    phonetic_spelling.split("·").count if has_syllables?
  end

  # TODO: Create shell test
  def is_duplicate?
    Word.search(name).map { |w| w.definition }.include?(definition)
  end

  # TODO: Create shell test
  def self.search(name)
    where(name: name.downcase)
  end

  # TODO: Create shell test
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

  # TODO: Create shell test
  def self.random_excluding(num, word_id)
    where.not(id: word_id).random(num)
  end

  # TODO: Create shell test
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

  # TODO: Create shell test
  def has_photo?
    photo?
  end

  # TODO: Create shell test
  def has_examples?
    !Example.where(word: self).blank?
  end

  # TODO: Create shell test
  def has_meaning_alts?
    !MeaningAlt.where(word: self).blank?
  end

  # TODO: Create shell test
  def has_ex_non_exs?
    !ExampleNonExample.where(word: self).blank?
  end

  # TODO Create test
  def has_syllables?
    !phonetic_spelling.nil?
  end

  # TODO: Create shell test
  def has_synonyms?
    !Thesaurus.send("synonyms", name).nil?
    # !WordSynonym.where(word: self).blank?
  end

  # TODO: Create shell test
  def has_antonyms?
    !Thesaurus.send("antonyms", name).nil?
    # !WordAntonym.where(word: self).blank?
  end

  # TODO: Create shell test
  def has_syns_or_ants?
    has_synonyms? || has_antonyms?
  end

  # TODO: Create shell test
  def doesnt_have_any_syn_or_ant?
    !has_synonyms? && !has_antonyms?
  end

  # TODO: Create shell test
  def has_sent_stems?
    !SentStem.where(word: self).blank?
  end

  # TODO: Create shell test
  def has_describe_mes?
    !DescribeMe.where(word: self).blank?
  end

  # TODO: Create shell test
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

  ######################################################
  #  EXPLORE WORDS BY SUBJECTS
  #  Source: https://www.flocabulary.com/wordlists/
  ######################################################

  def self.science
    ids = [
      10498, 10499, 10500, 10501
    ]
    Word.find(ids)
  end

  ######################################################
  #  EXPLORE WORDS BY GRADES
  #  Source: https://www.flocabulary.com/wordlists/
  ######################################################

  def self.first_grade
    ids = [
      5644, 5648, 8038, 5653, 5755, 5659, 8039, 8040, 5761, 5764, 5661, 5666,
      9134, 9138, 5770, 8046, 8058, 5668, 5672, 5672, 9154, 5773, 8060, 9161,
      5676, 5680, 5682, 5789, 5687, 5690, 8066, 5792, 5700, 5701, 5703, 5710,
      5796, 1614, 5712, 5807, 5718, 5720, 5738, 8070, 8071, 5740, 8072, 8077,
      9165, 5745, 463, 5812, 5644, 5648, 8038, 5653, 5755, 5659, 8039, 8040,
      5761, 5764, 5661, 5666, 9134, 9138, 5770, 8046, 8058, 5668, 5672, 5672,
      9154, 5773, 8060, 9161, 5676, 5680, 5682, 5789, 5687, 5690, 8066, 5792,
      5700, 5701, 5703, 5710, 5796, 1614, 5712, 5807, 5718, 5720, 5738, 8070,
      8071, 5740, 8072, 8077, 9165, 5745, 463, 5812, 5644, 5648, 8038, 5653,
      5755, 5659, 8039, 8040, 5761, 5764, 5661, 5666, 9134, 9138, 5770, 8046,
      8058, 5668, 5672, 5672, 9154, 5773, 8060, 9161, 5676, 5680, 5682, 5789,
      5687, 5690, 8066, 5792, 5700, 5701, 5703, 5710, 5796, 1614, 5712, 5807,
      5718, 5720, 5738, 8070, 8071, 5740, 8072, 8077, 9165, 5745, 463, 5812,
      5813, 8078, 7920, 5820, 5826, 8080, 8081, 8087, 8089, 5827, 5830, 5831,
      5837, 5841, 876, 5844, 8093, 5845, 8096, 5848, 5849, 8104, 9170, 9173,
      5860, 5862, 5870, 8106, 8116, 9175, 8125, 9181, 8131, 5872, 8138, 8145,
      9182, 8150, 5875, 5877, 5881, 5887, 8159, 5894, 473, 5896, 8169, 8170,
      8177, 5898, 8187, 2318, 8195, 9190, 8201, 5899, 935, 5902, 5909, 252,
      9219, 9224, 5914, 5940, 1685, 5949, 5953, 9241, 5956, 8202, 5969, 9259,
      5975, 5980, 9260, 5983, 8211, 5989, 9261, 8213, 5991, 5995, 6005, 6008,
      6014, 6016, 8219, 6019, 9262, 6021, 6026, 8220, 6040, 8227, 6053, 6060,
      6064, 4883, 6070, 8244, 8248, 9264, 6082, 6091, 6091, 8251
    ]
    Word.find(ids)
  end

  def self.second_grade
    ids = [
      4413, 8252, 9037, 4415, 4416, 8259, 4420, 4425, 8265, 4427, 8281, 2422,
      4431, 4433, 4435, 4451, 739, 8293, 4464, 2108, 4472, 4483, 9039, 3035,
      4489, 8300, 4492, 4499, 8323, 8331, 4502, 4503, 8376, 8383, 4514, 8394,
      8408, 8417, 4525, 8423, 4527, 4529, 8430, 8435, 9043, 4541, 4555, 9047,
      8456, 4559, 8460, 1572, 8462, 8466, 8469, 4563, 9053, 4568, 8472, 9054,
      8473, 8494, 4585, 4596, 4612, 4622, 9061, 4634, 4635, 4640, 9074, 4647,
      3403, 4652, 4655, 4659, 4665, 4670, 4672, 4681, 9076, 4683, 8497, 4685,
      8505, 8510, 4687, 8514, 4693, 4696, 4701, 8528, 899, 4711, 4722, 4724,
      8540, 8547, 4746, 4752, 4760, 9078, 4763, 8552, 4775, 9096, 8559, 8562,
      4777, 4786, 4809, 9103, 9110, 8577, 8583, 8585, 4819, 4831, 8590, 4836,
      4846, 8598, 4855, 4877, 4880, 9114, 9115, 4883, 4892, 8608, 4894, 8611,
      4905, 4909, 9119, 8615, 8622, 4910, 9122, 4918
    ]
    Word.find(ids)
  end

  def self.third_grade
    ids = [
      368, 6375, 6384, 6386, 2643, 6418, 6423, 8628, 6430, 8632, 6431, 2548,
      6435, 6439, 8635, 6446, 6449, 6461, 6466, 8935, 6470, 6476, 8945, 2364,
      8639, 8646, 2310, 6496, 6498, 6501, 8653, 6506, 6515, 6521, 6525, 6526,
      6528, 6533, 8656, 8953, 6537, 6539, 6546, 3145, 6553, 891, 6565, 6566,
      8661, 1677, 8961, 6571, 8663, 3146, 6572, 6579, 2288, 8668, 6587, 6590,
      6595, 6597, 379, 6606, 8964, 8677, 8683, 1683, 8690, 2197, 6622, 6626,
      6630, 8693, 6633, 6642, 8967, 8701, 8970, 8702, 8973, 8704, 8705, 8707,
      8975, 8979, 6646, 8709, 6647, 6650, 8718, 8982, 2067, 8720, 8730, 6661,
      2000, 6665, 6675, 5309, 8988, 6677, 8731, 2253, 8990, 6685, 8735, 6692,
      8996, 8747, 9000, 9009, 8751, 780, 8765, 8771, 9012, 3191, 9016, 9022,
      6693, 6704, 8779, 368, 6375, 6384, 6386, 2643, 6418, 6423, 8628, 6430,
      8632, 6431, 2548, 6435, 6439, 8635, 6446, 6449, 6461, 6466, 8935, 6470,
      6476, 8945, 2364, 8639, 8646, 2310, 6496, 6498, 6501, 8653, 6506, 6515,
      6521, 6525, 6526, 6528, 6533, 8656, 8953, 6537, 6539, 6546, 3145, 6553,
      891, 6565, 6566, 8661, 1677, 8961, 6571, 8663, 3146, 6572, 6579, 2288,
      8668, 6587, 6590, 6595, 6597, 379, 6606, 8964, 8677, 8683, 1683, 8690,
      2197, 6622, 6626, 6630, 8693, 6633, 6642, 8967, 8701, 8970, 8702, 8973,
      8704, 8705, 8707, 8975, 8979, 6646, 8709, 6647, 6650, 8718, 8982, 2067,
      8720, 8730, 6661, 2000, 6665, 6675, 5309, 8988, 6677, 8731, 2253, 8990,
      6685, 8735, 6692, 8996, 8747, 9000, 9009, 8751, 780, 8765, 8771, 9012,
      3191, 9016, 9022, 6693, 6704, 8779, 6709, 6716, 6718, 6727, 8784, 6732,
      8786, 8789, 6734, 6740, 6746, 6757, 9027, 8796, 6762, 9034, 6767
    ]
    Word.find(ids)
  end

  def self.fourth_grade
    ids = [
      3873, 3874, 3892, 3896, 3903, 3907, 3908, 3912, 3914, 3917, 3921, 3928,
      3935, 3940, 3944, 3946, 3949, 3955, 3958, 3964, 3969, 3975, 3979, 3981,
      3987, 3992, 3994, 3996, 3998, 4004, 4007, 4009, 4018, 500, 4029, 4039,
      4050, 4057, 4062, 4067, 4071, 4072, 4082, 4086, 4087, 4093, 4097, 443,
      4107, 4108, 4129, 4132, 4134, 4136, 4142, 4144, 4146, 4155, 4158, 4163,
      4168, 4172, 4178, 4181, 4186, 4198, 4201, 4203, 4207, 4210, 4213, 4215,
      4223, 4226, 4232, 4243, 4249, 4255, 4262, 4267, 4273, 4278, 4280, 4282,
      4284, 4290, 4299, 4301, 4316, 8801, 8802, 8805, 1198, 4921, 8809, 4926,
      8810, 4930, 8814, 8820, 4933, 411, 4936, 4944, 4954, 8824, 8828, 8836,
      4959, 4962, 8841, 8850, 8870, 4965, 4980, 4985, 8892, 8899, 2988, 4991,
      8902, 4997, 5003, 5010, 8904, 8907, 5021, 5025, 8917, 2995, 5034, 5038,
      8921, 8923, 5040, 5042, 8926, 5043, 5044, 8932
    ]
    Word.find(ids)
  end

  def self.fifth_grade
    ids = [
    	9265, 6096, 9266, 5057, 6099, 9273, 6101, 9274, 6104, 1060, 9284, 6107,
      3912, 6109, 6114, 267, 6125, 9285, 9288, 6126, 6130, 874, 9291, 6134,
      9293, 9296, 6136, 6145, 9298, 6155, 9308, 6159, 6165, 9310, 5563, 6166,
      9316, 9328, 6169, 9341, 6171, 6177, 6188, 9343, 9346, 6192, 6197, 6203,
      6211, 6213, 6215, 6216, 6220, 9347, 6223, 3224, 9351, 9353, 9357, 6226,
      6227, 9360, 6231, 9361, 6233, 9366, 6234, 6237, 9371, 6238, 4360, 1755,
      6244, 6247, 9373, 9376, 991, 6250, 992, 6265, 6267, 2426, 9378, 6269,
      6270, 6273, 9379, 6285, 6286, 680, 9380, 9386, 9390, 9395, 6288, 9399,
      6290, 2895, 6293, 9400, 9409, 882, 9411, 6302, 6305, 9416, 9421, 9424,
      6307, 9428, 6308, 6319, 6321, 6326, 9432, 6329, 9433, 6333, 9435, 9438,
      9444, 9451, 9458, 9459, 6334, 6336, 6338, 6345, 9462, 8011, 9468, 6349,
      6351, 6353, 9469, 9473, 6363, 2053, 6369, 9476
    ]
    Word.find(ids)
  end

  def self.sixth_grade
    ids = [
      5050, 9488, 5057, 9489, 9496, 5065, 9498, 9504, 1144, 8632, 9506, 5067,
      9509, 6107, 5071, 9515, 9524, 9527, 5073, 5074, 9529, 5077, 5082, 9533,
      2663, 5083, 9537, 5085, 5092, 5108, 5112, 9543, 5113, 9545, 5115, 5118,
      9547, 9548, 9558, 5123, 9559, 9561, 5124, 5129, 9564, 5131, 9569, 9571,
      5133, 5134, 9573, 5136, 5140, 5144, 5145, 5153, 9576, 9580, 5159, 9581,
      5171, 5178, 9587, 9591, 5180, 5182, 9593, 5187, 9599, 1693, 9604, 9610,
      9615, 5199, 9616, 5202, 5205, 9621, 9623, 5209, 5211, 5217, 9631, 9634,
      9643, 9646, 5221, 5223, 1698, 5226, 5227, 9654, 9657, 5232, 9661, 9671,
      9681, 9686, 9690, 5235, 9696, 5237, 9700, 5241, 9701, 655, 5248, 9703,
      6237, 5252, 9707, 9710, 5254, 5262, 5263, 9713, 5266, 5267, 9715, 9717,
      9719, 9721, 9725, 1068, 9727, 9732, 9733, 5268, 5271, 9737, 5273, 5276,
      9743, 9747, 9748, 9751, 5280, 5283, 9755, 9757, 5291, 9759, 5297, 9761,
      5298, 9763, 9766, 5299, 9767, 5301, 9771, 5302, 5305, 5306, 5308, 5309,
      9773, 5311, 9776, 5315, 9783, 9785, 3073, 9787, 9788, 3075, 843, 9792,
      9795, 9799, 9801, 9804, 9805, 9811, 9813, 9817, 9819, 9823, 9825, 9827,
      9832, 9835, 358, 9836, 9837, 9839, 3038, 9841, 2398, 9843, 9844, 2522,
      9857, 9861, 2961, 9865, 9866, 9867, 9874, 9885, 9887, 9889, 2662, 9893,
      9895, 9898, 9899, 2406, 9904, 9908]
    Word.find(ids)
  end

  def self.seventh_grade
    ids = [
      3243, 3249, 3253, 3262, 3268, 3273, 3281, 3012, 3306, 3309, 3315, 3322,
      3333, 3339, 3346, 588, 3351, 3357, 3360, 3369, 3372, 3377, 3301, 3382,
      3384, 3387, 3676, 3680, 9911, 9914, 9916, 9917, 9919, 9922, 9924, 9927,
      9934, 2455, 9935, 9939, 9940, 9942, 9943, 9952, 3246, 3251, 3255, 3266,
      3270, 3275, 3287, 3299, 3302, 3308, 3312, 3319, 3327, 3336, 3345, 3347,
      3352, 3358, 3362, 3371, 3374, 3378, 3383, 3386, 3389, 3691, 1278, 3681,
      9956, 9963, 9964, 892, 9966, 9967, 1509, 9968, 401, 9970, 9974, 9976,
      9977, 9979, 1414, 3392, 3396, 3397, 3400, 3401, 3403, 3406, 3412, 3413,
      3414, 3415, 3417, 3421, 3422, 3423, 3424, 3427, 3430, 3434, 3438, 3440,
      3441, 3445, 3692, 9980, 9981, 9983, 9984, 9986, 9987, 9990, 9991, 9998,
      9999, 3696, 10001, 10006, 3684, 3688, 3446, 3454, 10009, 3468, 3473, 3481,
      3489, 3492, 3496, 3502, 3506, 3508, 3516, 3519, 3522, 3536, 3540, 3543,
      3548, 3555, 3564, 3566, 3569, 3576, 3580, 3582, 3585, 3589, 3597, 3602,
      3613, 3617, 3620, 3625, 3631, 3635, 3641, 3652, 3654, 10010, 3659, 3664,
      3667, 3670, 3451, 3462, 3470, 3477, 3485, 3491, 3494, 3497, 3504, 3507,
      3509, 3517, 3520, 3527, 3530, 3539, 3541, 3546, 3552, 3556, 3565, 3567,
      3574, 3577, 3583, 3588, 3592, 3601, 3605, 3619, 3621, 3629, 3634, 3639,
      3649, 3655, 1216, 777, 3665, 442
    ]
    Word.find(ids)
  end

  def self.eigth_grade
    ids = [
      10016, 3183, 5319, 5532, 5536, 5538, 5541, 5543, 5321, 5546, 10016, 3183,
      5319, 5532, 5536, 5538, 5541, 5543, 5321, 5546, 10017, 5324, 5327, 5330,
      10020, 5548, 10023, 5337, 2377, 10025, 5341, 10027, 5348, 5552, 10031,
      10033, 5556, 10035, 5350, 10016, 3183, 5319, 5532, 5536, 5538, 5541, 5543,
      5321, 5546, 10017, 5324, 5327, 5330, 10020, 5548, 10023, 5337, 2377,
      10025, 5341, 10027, 5348, 5552, 10031, 10033, 5556, 10035, 5350, 10038,
      10041, 5558, 10043, 5351, 5352, 5356, 10047, 10048, 5357, 5359, 5361,
      5560, 5563, 5364, 5366, 5367, 10056, 5369, 10063, 5371, 5564, 10070, 5567,
      5378, 10074, 5380, 10076, 5383, 5572, 5388, 5390, 10077, 1618, 5391, 5392,
      10082, 5394, 10083, 5574, 5399, 3010, 5403, 10084, 3865, 5407, 5409, 5412,
      5415, 10087, 10090, 10092, 5417, 10094, 5583, 5223, 5420, 5423, 10097,
      10098, 5585, 5587, 5425, 5426, 5590, 10100, 5591, 10102, 5596, 5428,
      10105, 5431, 5433, 5438, 5443, 5444, 10110, 5446, 10113, 5451, 5453, 5456,
      10117, 10121, 5458, 5597, 5463, 10124, 5467, 1113, 5600, 10127, 10132,
      5471, 5474, 5605, 5475, 10135, 5606, 5481, 10137, 10139, 10146, 5608,
      5609, 10148, 5484, 10150, 5488, 10151, 5610, 5491, 10154, 5494, 10158,
      10159, 5497, 10160, 5499, 5613, 5615, 10163, 1236, 10168, 10169, 10171,
      10176, 10179, 962, 10180, 10183, 10185, 10191, 10192, 10194, 10195, 10200,
      10202, 10207, 5617, 5620, 5500, 10209, 5624, 5625, 5501, 5506, 10211,
      5508, 5510, 4392, 10213, 1079, 730, 5631, 5514, 5633, 4355, 1245, 5638,
      10215, 10217, 5528, 5642, 10221, 10223, 10225, 10231, 10232, 10236, 10243,
      10244, 10246, 10247, 10250, 10252, 10253, 10254, 5530, 10256
    ]
    Word.find(ids)
  end

  ######################################################
  #  EXPLORE 2ND HARLEM SPELLING BEE WORDS BY GRADES
  #  Source: https://www.flocabulary.com/wordlists/
  ######################################################

  def self.first_grade_hsb_2
    ids = [
      5644, 5648, 8038, 5653, 5755, 5659, 8039, 8040, 5661, 5666, 8046, 8058,
      5668, 5672, 8060, 5676, 5680, 5789, 5687, 5690, 8066, 5792, 5701, 5796,
      5807, 5718, 5720, 5738, 8070, 8071, 5740, 8072, 8077, 463, 5812, 5644,
      5648, 8038, 5653, 5755, 5659, 8039, 8040, 5661, 5666, 8046, 8058, 5668,
      5672, 8060, 5676, 5680, 5789, 5687, 5690, 8066, 5792, 5701, 5796, 5807,
      5718, 5720, 5738, 8070, 8071, 5740, 8072, 8077, 463, 5812, 5813, 8078,
      7920, 5820, 8080, 8081, 8087, 8089, 5827, 5830, 5831, 5837, 5844, 8093,
      8096, 5848, 8104, 5860, 5862, 8106, 8116, 8125, 8131, 5872, 8138, 8145,
      8150, 5875, 8159, 5894, 473, 5896, 8169, 8170, 8177, 8187, 8195, 8201,
      5899, 5902, 252, 5940, 5953, 8202, 5969, 5983, 8211, 8213, 5991, 5995,
      6008, 6014, 6016, 8219, 6021, 8220, 6040, 8227, 6060, 4883, 8244, 8248,
      6082, 6091, 8251
    ]
    Word.find(ids)
  end

  def self.second_grade_hsb_2
    ids = [
      8252, 4415, 8259, 4420, 4425, 8265, 8281, 2422, 4431, 739, 8293, 2108,
      4472, 4483, 3035, 4489, 8300, 4492, 4499, 8323, 8331, 4503, 8376, 8383,
      4514, 8394, 8408, 8417, 4525, 8423, 4529, 8430, 8435, 4541, 8456, 8460,
      1572, 8462, 8466, 8469, 4563, 4568, 8472, 8473, 8494, 4585, 4622, 4640,
      3403, 4652, 4655, 4659, 4665, 4670, 4672, 4683, 8497, 4685, 8505, 8510,
      4687, 8514, 4693, 4701, 8528, 899, 4722, 4724, 8540, 8547, 4746, 4752,
      4763, 8552, 4775, 8559, 8562, 4777, 4786, 4809, 8577, 8583, 8585, 4819,
      4831, 8590, 4836, 4846, 8598, 4855, 4877, 4883, 4892, 8608, 4894, 8611,
      4905, 8615, 8622, 4910
    ]
    Word.find(ids)
  end

  def self.third_grade_hsb_2
    ids = [
      6375, 6384, 2643, 6418, 6423, 8628, 6430, 8632, 2548, 6435, 6439, 8635,
      6446, 6449, 6470, 2364, 8639, 8646, 2310, 6496, 6498, 6501, 8653, 6515,
      6521, 6525, 6526, 6528, 6533, 8656, 6539, 6546, 3145, 891, 6565, 6566,
      8661, 6571, 8663, 6572, 6579, 2288, 8668, 6587, 6590, 6595, 6597, 379,
      6606, 8677, 8683, 1683, 8690, 6622, 6630, 8693, 6642, 8701, 8702, 8704,
      8705, 8707, 6646, 8709, 6647, 6650, 8718, 2067, 8720, 8730, 2000, 6665,
      6675, 5309, 8731, 2253, 6685, 8735, 6692, 8747, 8751, 780, 8765, 8771,
      3191, 6693, 6704, 8779, 6709, 6716, 8784, 8786, 8789, 6734, 6740, 6746,
      6757, 8796, 6762, 6767
    ]
    Word.find(ids)
  end

  def self.fourth_grade_hsb_2
    ids = [
      3873, 3874, 3892, 3896, 3903, 3907, 3921, 3935, 3944, 3949, 3955, 3958,
      3964, 3969, 3975, 3979, 3987, 3992, 3994, 3996, 3998, 4004, 4007, 4018,
      500, 4039, 4050, 4057, 4062, 4071, 4082, 4087, 4093, 4097, 443, 4107,
      4108, 4134, 4136, 4142, 4146, 4158, 4168, 4172, 4181, 4201, 4203, 4210,
      4213, 4215, 4223, 4226, 4243, 4255, 4262, 4278, 4280, 4284, 4290, 4299,
      4301, 4316, 8802, 8805, 1198, 8809, 4926, 8810, 4930, 8814, 8820, 4933,
      411, 4936, 4944, 4954, 8824, 8828, 4959, 4962, 8850, 4965, 4980, 4985,
      8899, 4991, 8902, 4997, 5010, 8904, 8907, 5021, 5025, 2995, 5034, 8921,
      5040, 5042, 5043, 5044
    ]
    Word.find(ids)
  end

  def self.fifth_grade_hsb_2
    ids = [
      6096, 9266, 5057, 6099, 9273, 6104, 1060, 9284, 6107, 3912, 6109, 6114,
      6125, 9285, 9288, 874, 9291, 6134, 9296, 6145, 6155, 9308, 6159, 6165,
      9310, 5563, 6166, 9316, 6169, 6171, 6177, 6188, 6203, 6211, 6213, 6215,
      6220, 9353, 9357, 6226, 6227, 9360, 6231, 9361, 6233, 9366, 6234, 6237,
      9371, 6238, 4360, 6244, 9376, 991, 6250, 6265, 2426, 9378, 6269, 6270,
      9379, 680, 9380, 9386, 9390, 9395, 9399, 6290, 2895, 6293, 9400, 9409,
      882, 9411, 6302, 6305, 9421, 9424, 9428, 6308, 6319, 6321, 6326, 9432,
      6329, 9433, 9459, 6334, 6336, 6345, 9462, 8011, 6349, 6351, 9469, 9473,
      6363, 2053, 6369, 9476
    ]
    Word.find(ids)
  end

  def self.sixth_grade_hsb_2
    ids = [
      9488, 9489, 5065, 9498, 1144, 8632, 9506, 9509, 6107, 9515, 5074, 5082,
      2663, 5083, 5092, 5113, 5118, 9548, 9558, 5123, 5124, 5129, 9569, 5133,
      5134, 5136, 5145, 5153, 9580, 5159, 9581, 5171, 5178, 9587, 9593, 5187,
      9599, 9604, 5199, 9621, 5209, 9643, 5223, 1698, 5226, 5227, 9654, 9671,
      9690, 9696, 9700, 5241, 5248, 5252, 9710, 9713, 5267, 9715, 9719, 9721,
      1068, 9732, 9733, 5268, 5271, 9737, 9747, 9748, 5283, 9759, 9763, 5305,
      5306, 5308, 5309, 5311, 9785, 3073, 9787, 3075, 9795, 9799, 9805, 9813,
      9817, 9825, 9832, 9835, 358, 9836, 9837, 3038, 9865, 9867, 9874, 9885,
      9893, 9895, 2406, 9904
    ]
    Word.find(ids)
  end

  def self.seventh_grade_hsb_2
    ids = [
      3249, 3253, 3262, 3281, 3306, 3315, 3322, 3351, 3360, 3369, 3382, 3676,
      3680, 9917, 9935, 9940, 9943, 9952, 3251, 3266, 3270, 3275, 3287, 3299,
      3302, 3312, 3336, 3345, 3352, 3362, 3383, 3389, 3691, 1278, 9963, 892,
      1509, 9968, 9970, 9974, 9977, 9979, 1414, 3392, 3397, 3403, 3412, 3413,
      3415, 3422, 3427, 3434, 3440, 3441, 3692, 9980, 9981, 9983, 9986, 9991,
      10001, 10006, 3684, 3688, 3454, 10009, 3481, 3492, 3502, 3506, 3508,
      3522, 3536, 3543, 3548, 3580, 3582, 3602, 3625, 3631, 3635, 3641, 10010,
      3667, 3670, 3451, 3477, 3491, 3494, 3517, 3539, 3541, 3552, 3577, 3583,
      3592, 3619, 3634, 3665, 442
    ]
    Word.find(ids)
  end

  def self.eigth_grade_hsb_2
    ids = [
      5532, 5536, 5538, 5541, 5321, 5546, 5324, 10023, 10025, 5348, 5552, 10033,
      5556, 5350, 10041, 10043, 5351, 5356, 10048, 5357, 5359, 5361, 5560, 5563,
      5364, 5366, 5564, 5567, 10074, 5380, 10076, 5388, 10077, 5391, 5392, 5399,
      3865, 5409, 10092, 5583, 5223, 5423, 5585, 5587, 5426, 5590, 5591, 5428,
      5438, 5444, 5446, 10113, 5451, 5453, 10117, 5597, 5463, 5600, 5471, 5474,
      5605, 10135, 5606, 10146, 10148, 5488, 10154, 5494, 10158, 10159, 5497,
      10160, 5613, 10169, 10176, 10179, 962, 10191, 10195, 10202, 10207, 5617,
      5500, 4392, 5514, 4355, 1245, 5638, 10215, 5642, 10232, 10236, 10243,
      10244, 10246, 10247, 10250, 10252, 10253, 10254
    ]
    Word.find(ids)
  end
end
