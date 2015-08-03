class WordSynonym < ActiveRecord::Base
  belongs_to :word
  belongs_to :synonym, class_name: "Word"

  validates :word, presence: true
  validates :synonym, presence: true
end
