class ExampleNonExample < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  has_many :game_stat_example_non_examples, dependent: :destroy
  has_many :game_stats, through: :game_stat_example_non_examples

  validates :text, presence: true, uniqueness: true
  validates :answer, presence: true
  validates :feedback, presence: true, uniqueness: true
  validates :user, presence: true
  validates :word, presence: true
end
