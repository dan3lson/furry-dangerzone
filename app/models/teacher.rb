class Teacher < User
  has_many :classrooms, dependent: :destroy
  has_many :students, through: :classrooms, dependent: :destroy
  has_many :meaning_alts, dependent: :destroy
  has_many :example_non_examples, dependent: :destroy
  has_many :sent_stems, dependent: :destroy
  has_many :describe_mes, dependent: :destroy

  def has_students?
    !Student.where(teacher: self).empty?
  end

  def has_classroom?(classroom)
    !classrooms.where(name: classroom.name).empty?
  end

  def has_classrooms?
    !Classroom.where(teacher: self).empty?
  end

  def has_classroom_activity?
    students = Student.where(teacher: self)
    has_classrooms? ? students.any? { |s| s.has_any_activity? } : false
  end

  def has_unreviewed_frees?
    students = Student.where(teacher: self)
    has_classrooms? ? students.any? { |s| !s.unreviewed_frees.empty? } : false
  end

  # TODO Delete and figure out database/relationships issue
  # TODO Create test
  def example_non_examples
    ExampleNonExample.where(user: self)
  end

  # TODO Create test
  def has_ex_non_exs?
    !example_non_examples.blank?
  end

  # TODO Delete and figure out database/relationships issue
  # TODO Create test
  def meaning_alts
    MeaningAlt.where(user_id: self)
  end

  # TODO Create test
  def has_meaning_alts?
    !meaning_alts.blank?
  end

  def example_non_examples_grouped
    example_non_examples.group_by { |e| e.word.name }.each do |name, array|
      puts "#{name}: #{array.count}"
    end
  end

  # TODO Create test
  def created_words
    Word.where(creator_id: self.id)
  end

  # TODO Create test
  def has_created_words?
    !created_words.empty?
  end

  # TODO Create test
  def has_created_content?
    has_created_words?
  end
end
