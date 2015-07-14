class Source < ActiveRecord::Base
  has_many :user_sources, dependent: :destroy
  has_many :users, through: :user_sources

  validates :name, presence: true, uniqueness: true

  default_scope -> { order('sources.name ASC') }
end
