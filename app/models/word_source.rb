class WordSource < ActiveRecord::Base
  belongs_to :word
  belongs_to :source

  validates :word, presence: true
  validates :source, presence: true
end
