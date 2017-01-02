class WordExampleNonExample < ActiveRecord::Base
  belongs_to :word
  belongs_to :example_non_example

  validates :word, presence: true
  validates :example_non_example, presence: true
end
