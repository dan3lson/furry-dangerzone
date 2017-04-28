class FreestyleLekTale < ActiveRecord::Base
  belongs_to :freestyle
  has_one :game_stat_freestyle_lek_tale, dependent: :destroy
  has_one :game_stat, through: :game_stat_freestyle_lek_tale

  validates :freestyle, presence: true
  validates :word_ids, presence: true

  serialize :word_ids, Array
end
