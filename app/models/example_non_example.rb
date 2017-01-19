class ExampleNonExample < ActiveRecord::Base
  has_many :word_example_non_examples, dependent: :destroy
  has_many :words, through: :word_example_non_examples

  validates :text, presence: true
  validates :answer, presence: true
  validates :feedback, presence: true
end
