class Blog < ActiveRecord::Base
  default_scope -> { order('blogs.created_at DESC') }

  has_many :comments

  validates :title, presence: true

  # only until done in heroku
  def self.create_initial_titles
    create!(title: "All About Leksi Part 1")
    create!(title: "All About Leksi Part 2")
    create!(title: "Six Words That Don\'t Mean What You Think")
    create!(title: "10 Quotes on How Important Vocabulary Really Is")
  end
end
