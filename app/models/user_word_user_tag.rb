class UserWordUserTag < ActiveRecord::Base
  belongs_to :user_word
  belongs_to :user_tag

  validates :user_word, presence: true
  validates :user_tag, presence: true
end
