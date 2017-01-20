class ExampleNonExample < ActiveRecord::Base
  belongs_to :user
  belongs_to :word

  validates :text, presence: true, uniqueness: true
  validates :answer, presence: true
  validates :feedback, presence: true, uniqueness: true
  validates :user, presence: true
  validates :word, presence: true
end
