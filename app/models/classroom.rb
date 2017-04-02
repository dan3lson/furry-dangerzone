class Classroom < ActiveRecord::Base
  belongs_to :teacher
  has_many :students, dependent: :destroy

  validates :name, presence: true
  validates :teacher, presence: true

  # TODO Create test
  def has_students?
    !Student.where(classroom: self).empty?
  end
end
