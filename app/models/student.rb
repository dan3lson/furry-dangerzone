class Student < User
  belongs_to :teacher
  belongs_to :classroom

  validates :teacher, presence: true
  validates :classroom, presence: true

  def self.alphabetical
    order(:username)
  end

  # TODO Create test shell
  def belongs_to_classroom?
    !classroom.nil?
  end

  # TODO Create test shell
  def has_classmates?
    belongs_to_classroom? ? !classroom.students.empty? : nil
  end

  # TODO Create test shell
  def classmates
    has_classmates? ? classroom.students : nil
  end
end
