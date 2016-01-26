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

  # only until done in heroku
  def self.create_initial_titles
    create!(
      title: "All About Leksi Part 1",
      content: "Content for this blog post.",
      icon: "map-o",
      slug: "all_about_leksi_part_1"
    )
    create!(
      title: "All About Leksi Part 2",
      content: "Content for this blog post.",
      icon: "map-o",
      slug: "all_about_leksi_part_2"
    )
    create!(
      title: "Six Words That Don\'t Mean What You Think",
      content: "Content for this blog post.",
      icon: "map-signs",
      slug: "six_words_that_dont_mean_what_you_think"
    )
    create!(
      title: "10 Quotes on How Important Vocabulary Really Is",
      content: "Content for this blog post.",
      icon: "comment",
      slug: "10_quotes_on_vocabulary_importance"
    )
  end
end
