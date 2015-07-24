class Tag < ActiveRecord::Base
  has_many :user_tags, dependent: :destroy
  has_many :users, through: :user_tags
  has_many :word_tags, dependent: :destroy
  has_many :words, through: :word_tags

  validates :name, presence: true, uniqueness: true

  default_scope -> { order('tags.name ASC') }
end
