class Tag < ActiveRecord::Base
  default_scope -> { order('tags.name ASC') }

  has_many :user_tags, dependent: :destroy
  has_many :users, through: :user_tags
  has_many :word_tags, dependent: :destroy
  has_many :words, through: :word_tags

  validates :name, presence: true, uniqueness: true
end
