class Word < ActiveRecord::Base
  has_many :user_words, dependent: :destroy
  has_many :users, through: :user_words

  before_create { self.name = name.downcase }

  validates :name, presence: true, uniqueness: true
  validates :pronunciation, presence: true
  validates :definition, presence: true
  validates :part_of_speech, presence: true

  default_scope -> { order('words.name ASC') }

  def self.search(word_name)
    if word_name
      where("name like ?", "%#{word_name}%")
    end
  end
end
