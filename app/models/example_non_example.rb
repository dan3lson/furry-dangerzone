class ExampleNonExample < ActiveRecord::Base
  belongs_to :user
  # belongs_to :teacher, class_name: "User", foreign_key: "user_id"
  belongs_to :word
  has_many :game_stat_example_non_examples, dependent: :destroy
  has_many :game_stats, through: :game_stat_example_non_examples

  validates :text, presence: true, uniqueness: true
  validates :answer, presence: true
  validates :feedback, presence: true, uniqueness: true
  validates :user, presence: true
  validates :word, presence: true

  # TODO Test
  scope :last_24_hours, -> (time = "updated_at") {
    where("#{time} > ?", 24.hours.ago)
  }
end
