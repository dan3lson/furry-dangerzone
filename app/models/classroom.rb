class Classroom < ActiveRecord::Base
  belongs_to :teacher, class_name: "Teacher", foreign_key: "user_id"
  has_many :students

  validates :name, presence: true
  validates :teacher, presence: true

  # TODO Create test
  def has_students?
    !Student.where(classroom: self).empty?
  end
end
