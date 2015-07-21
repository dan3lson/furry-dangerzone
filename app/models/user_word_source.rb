class UserWordSource < ActiveRecord::Base
  belongs_to :user
  belongs_to :word_source

  validates :user, presence: true
  validates :word_source, presence: true
end
