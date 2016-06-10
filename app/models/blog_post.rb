class BlogPost < ActiveRecord::Base
  default_scope -> { order('blog_posts.created_at DESC') }

  has_many :comments

  validates :title, presence: true
  validates :content, presence: true
  validates :icon, presence: true
  validates :slug, presence: true

  # not tested
  def to_param
    slug
  end
end
