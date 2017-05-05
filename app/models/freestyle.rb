class Freestyle < ActiveRecord::Base
  belongs_to :user_word
  has_one :freestyle_sent_stem, dependent: :destroy
  has_one :sent_stem, through: :freestyle_sent_stem
  has_one :freestyle_rel_word, dependent: :destroy
  has_one :freestyle_lek_tale, dependent: :destroy
  has_one :freestyle_desc_me, dependent: :destroy
  has_one :describe_me, through: :freestyle_desc_me
  has_one :game_stat_freestyle, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :input, presence: true
  validates :status, presence: true
  validates :user_word, presence: true

  scope :unreviewed, -> { where(status: "not reviewed") }
  scope :reviewed, -> { where(status: ["pass", "redo"]) }
  scope :pass, -> { where(status: "pass") }
  scope :redo, -> { where(status: "redo") }
  scope :latest, -> { order("created_at DESC") }

  def game
    user_word.game
  end

  def user
    user_word.user
  end

  def word
    user_word.word
  end

  def has_comments?
    !Comment.where(commentable_id: self.id).empty?
  end

  def self.update_status_redone(params)
    unless params.empty?
      Freestyle.find(params).update_attributes(status: "redone")
    end
  end
end
