class Student < User
  belongs_to :teacher, class_name: "User", foreign_key: "user_id"
  # belongs_to :teacher
  belongs_to :classroom

  validates :teacher, presence: true
  validates :classroom, presence: true
end
