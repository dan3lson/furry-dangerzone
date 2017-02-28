class GameStatExampleNonExample < ActiveRecord::Base
  belongs_to :game_stat
  belongs_to :example_non_example

  validates :game_stat, presence: true
  validates :example_non_example, presence: true
end
