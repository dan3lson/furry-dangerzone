class WordSource < ActiveRecord::Base
  belongs_to :word
  belongs_to :source
  has_many :user_word_sources
  has_many :users, through: :user_word_sources

  validates :word, presence: true
  validates :source, presence: true

  scope :untagged, -> { where(source: nil) }
end
