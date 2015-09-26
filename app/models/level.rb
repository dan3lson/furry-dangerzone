class Level < ActiveRecord::Base
  has_many :game_levels
  has_many :games, through: :game_levels

  validates :focus, presence: true
  validates :direction, presence: true

  # Only for Prod. Delete after creation. # OKAY TO DELETE
  def self.create_freestyle_levels
    Level.create!(focus: "Semantic Map 1", direction: "Type a similar word.")
    Level.create!(focus: "Semantic Map 2", direction: "Type a similar word.")
    Level.create!(focus: "Semantic Map 3", direction: "Type a similar word.")
    Level.create!(focus: "Word Map 1", direction: "What word can be formed?")
    Level.create!(focus: "Word Map 2", direction: "What word can be formed?")
    Level.create!(focus: "Word Map 3", direction: "What word can be formed?")
    Level.create!(focus: "Definition Map 1", direction: "What do you think the word means?")
    Level.create!(focus: "Definition Map 2", direction: "What do you think the word means?")
    Level.create!(focus: "Definition Map 3", direction: "What do you think the word means?")
    Level.create!(focus: "Example Sentence 1", direction: "Create a sentence with the word in it.")
    Level.create!(focus: "Example Sentence 2", direction: "Create a sentence with the word in it.")
    Level.create!(focus: "Example Sentence 3", direction: "Create a sentence with the word in it.")
  end
end
