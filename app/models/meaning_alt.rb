class MeaningAlt < ActiveRecord::Base
  # TODO Should this should be destroyed with the word to which it belongs?
  belongs_to :word
  # TODO Should this should be destroyed with the user to which it belongs?
  belongs_to :user
  
  validates :text, presence: true
  validates :choices, presence: true
  validates :answer, presence: true
  validates :feedback, presence: true
  validates :word, presence: true
  validates :user, presence: true
end
