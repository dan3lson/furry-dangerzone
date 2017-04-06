class Classroom < ActiveRecord::Base
  belongs_to :teacher
  has_many :students, dependent: :destroy

  validates :name, presence: true
  validates :teacher, presence: true
  validates :grade, presence: true

  # TODO Create test
  def has_students?
    !Student.where(classroom: self).empty?
  end

  # TODO Create test
  def num_students
    students.count
  end

  def self.puts_pwds(class_id)
    find(class_id).students.each do |s|
      puts "Username: #{s.username}, Password: #{s.username}2017"
    end
  end
end
