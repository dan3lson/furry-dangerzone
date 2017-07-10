class Classroom < ActiveRecord::Base
  belongs_to :teacher
  has_many :students, dependent: :destroy

  validates :name, presence: true
  validates :teacher, presence: true
  validates :grade, presence: true

  # TODO Create test shell
  def has_students?
    !Student.where(classroom: self).empty?
  end

  # TODO Create test shell
  def num_students
    students.count
  end
end
