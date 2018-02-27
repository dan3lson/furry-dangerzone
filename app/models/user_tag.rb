class UserTag < ActiveRecord::Base
  belongs_to :teacher, class_name: "Teacher", foreign_key: "user_id"
  belongs_to :tag
  has_many :user_word_user_tags, dependent: :destroy
  has_many :user_words, through: :user_word_user_tags

  validates :teacher, presence: true
  validates :tag, presence: true
end
