class DescribeMe < ActiveRecord::Base
  belongs_to :word
  belongs_to :user

  validates :text, presence: true
  validates :word, presence: true
  validates :user, presence: true
end
