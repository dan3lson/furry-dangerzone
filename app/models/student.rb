class Student < User
  belongs_to :teacher
  belongs_to :classroom

  validates :teacher, presence: true
  validates :classroom, presence: true
end
