class Source < ActiveRecord::Base
  has_many :user_sources, dependent: :destroy
  has_many :users, through: :user_sources

  # Add an original_name column before
  # saving and display that instead?
  before_create { self.name = name.downcase }

  validates :name, presence: true, uniqueness: true

  default_scope -> { order('sources.name ASC') }
end
