class UserSource < ActiveRecord::Base
  belongs_to :user
  belongs_to :source

  validates :user, presence: true
  validates :source, presence: true
end
