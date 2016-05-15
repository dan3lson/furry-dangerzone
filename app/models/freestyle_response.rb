class FreestyleResponse < ActiveRecord::Base
  belongs_to :user_word

  validates :input, presence: true
  validates :focus, presence: true
  validates :user_word, presence: true

  # not tested
  def self.for(user_word)
    where(user_word_id: user_word.id)
  end

  # not tested
  def self.sorted_for(user_word)
    self.for(user_word).order(:id).map { |fr| fr.input }
  end
end
