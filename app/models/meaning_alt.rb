class MeaningAlt < ActiveRecord::Base
  belongs_to :word

  validates :text, presence: true
  validates :feedback, presence: true
  validates :word, presence: true
end
