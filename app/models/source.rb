class Source < ActiveRecord::Base
  has_many :user_sources, dependent: :destroy
  has_many :users, through: :user_sources
  has_many :word_sources, dependent: :destroy
  has_many :words, through: :word_sources

  validates :name, presence: true, uniqueness: true

  default_scope -> { order('sources.name ASC') }
end
