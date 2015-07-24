class UserTag < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag

  validates :user, presence: true
  validates :tag, presence: true
end
