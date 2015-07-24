class UserWordTag < ActiveRecord::Base
  belongs_to :user
  belongs_to :word_tag

  validates :user, presence: true
  validates :word_tag, presence: true
end
