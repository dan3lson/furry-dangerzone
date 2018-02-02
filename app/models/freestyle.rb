class Freestyle < ActiveRecord::Base
  belongs_to :user_word
  has_one :freestyle_sent_stem, dependent: :destroy
  has_one :sent_stem, through: :freestyle_sent_stem
  has_one :freestyle_rel_word, dependent: :destroy
  has_one :freestyle_lek_tale, dependent: :destroy
  has_one :freestyle_desc_me, dependent: :destroy
  has_one :describe_me, through: :freestyle_desc_me
  has_one :game_stat_freestyle, dependent: :destroy
  has_one :freestyle_ex_non_ex, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :input, presence: true
  validates :status, presence: true
  validates :user_word, presence: true

  # TODO Create test shell
  scope :unreviewed, -> { where(status: "not reviewed") }
  # TODO Create test shell
  scope :reviewed, -> { where(status: ["pass", "redo"]) }
  # TODO Create test shell
  scope :pass, -> { where(status: "pass") }
  # TODO Create test shell
  scope :redo, -> { where(status: "redo") }
  # TODO Create test shell
  scope :latest, -> { order("freestyles.created_at DESC") }
  # TODO Create test shell
  scope :last_24_hours, -> (time = "freestyles.updated_at") {
    where("#{time} > ?", 24.hours.ago)
  }

  # TODO Create test shell
  def game
    user_word.game
  end

  # TODO Create test shell
  def user
    user_word.user
  end

  # TODO Create test shell
  def word
    user_word.word
  end

  # TODO Create test shell
  def has_comments?
    !Comment.where(commentable_id: self.id).empty?
  end

  # TODO Create test shell
  def self.update_status_redone(params)
    unless params.empty?
      Freestyle.find(params).update_attributes(status: "redone")
    end
  end
end
