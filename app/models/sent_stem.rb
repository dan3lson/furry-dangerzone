class SentStem < ActiveRecord::Base
  belongs_to :word
  belongs_to :user

  validates :text, presence: true
  validates :word, presence: true
  validates :user, presence: true

  before_create { self.text = text.gsub("???", "____________") }
end
