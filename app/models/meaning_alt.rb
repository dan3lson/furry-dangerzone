class MeaningAlt < ActiveRecord::Base
  belongs_to :word
  belongs_to :user

  validates :text, presence: true
  validates :choices, presence: true
  validates :answer, presence: true
  validates :feedback, presence: true
  validates :word, presence: true
  validates :user, presence: true
end
