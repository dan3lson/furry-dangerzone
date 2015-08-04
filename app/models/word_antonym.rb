class WordAntonym < ActiveRecord::Base
  belongs_to :word
  belongs_to :antonym, class_name: "Word"

  validates :word, presence: true
  validates :antonym, presence: true
end
