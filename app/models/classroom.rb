class Classroom < ActiveRecord::Base
  belongs_to :teacher
  has_many :students, dependent: :destroy

  validates :name, presence: true
  validates :grade, presence: true
  validates :teacher, presence: true

  def has_students?
    !Student.where(classroom: self).empty?
  end

  def num_students
    students.count
  end
end
