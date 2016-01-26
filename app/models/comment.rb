class Comment < ActiveRecord::Base
  default_scope -> { order('comments.created_at DESC') }

  belongs_to :blog_post
  belongs_to :user

  validates :description, presence: true
  validates :blog_post, presence: true
end
