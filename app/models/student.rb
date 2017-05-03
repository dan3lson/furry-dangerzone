class Student < User
  belongs_to :teacher
  belongs_to :classroom

  validates :teacher, presence: true
  validates :classroom, presence: true

  def self.alphabetical
    order(:username)
  end

  # TODO Create test
  def has_classmates?
    !classroom.students.empty?
  end

  # TODO Create test
  def classmates
    classroom.students if has_classmates?
  end
end
