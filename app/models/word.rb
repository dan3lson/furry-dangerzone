class Word < ActiveRecord::Base
  has_many :user_words, dependent: :destroy
  has_many :users, through: :user_words
  has_many :word_sources, dependent: :destroy
  has_many :sources, through: :word_sources

  before_create { self.name = name.downcase }

  validates :name, presence: true, uniqueness: true
  validates :pronunciation, presence: true
  validates :definition, presence: true
  validates :part_of_speech, presence: true

  default_scope -> { order('words.name ASC') }

  def self.search(word_name)
    if word_name
      where("name like ?", "%#{word_name}%").limit(10)
    end
  end
end
