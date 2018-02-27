class Student < User
  belongs_to :teacher, class_name: "User"
  belongs_to :classroom

  validates :teacher, presence: true
  validates :classroom, presence: true

  scope :alphabetical, -> { order("LOWER(words.name)") }

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

  def user_words_with_tags
    user_words.includes(:user_tags).where.not(user_tags: { id: nil })
  end

  def has_tags?
    !user_words_with_tags.empty?
  end

  # TODO Create test
  def word_ids_for(tag)
    ut = UserTag.find_by(teacher: self, tag: tag)
    ut.user_words.pluck(:word_id)
  end
end
