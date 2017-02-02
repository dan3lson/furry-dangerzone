class SentStemStu < ActiveRecord::Base
  belongs_to :sent_stem
  belongs_to :user

  validates :response, presence: true
  validates :user, presence: true
  validates :sent_stem, presence: true
end
