class Teacher < User
  has_many :classrooms
  has_many :students, through: :classrooms
  has_many :meaning_alts
  has_many :example_non_examples
  has_many :sent_stems
  has_many :describe_mes
end
