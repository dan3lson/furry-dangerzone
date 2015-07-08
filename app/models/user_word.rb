class UserWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word

  validates :user, presence: true
  validates :word, presence: true
end
