class Comment < ActiveRecord::Base
  default_scope -> { order('comments.created_at DESC') }

  belongs_to :blog

  validates :description, presence: true
  validates :blog, presence: true
end
