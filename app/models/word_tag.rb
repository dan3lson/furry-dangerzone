class WordTag < ActiveRecord::Base
  belongs_to :word
  belongs_to :tag
  has_many :user_word_tags
  has_many :users, through: :user_word_tags

  validates :word, presence: true
  validates :tag, presence: true
end
