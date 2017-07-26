require 'rails_helper'

RSpec.describe Teacher, type: :model do
	let(:teacher) { FactoryGirl.create(:teacher) }
	let(:classroom) { FactoryGirl.create(:classroom, teacher: teacher) }
	let(:student1) { FactoryGirl.create(:student, classroom: classroom, teacher: teacher) }
	let(:student2) { FactoryGirl.create(:student, classroom: classroom, teacher: teacher) }
	let(:student3) { FactoryGirl.create(:student, classroom: classroom, teacher: teacher) }

  describe "#has_students?" do
    it "returns true" do
			student1

      expect(teacher.has_students?).to eq(true)
    end

    it "returns false" do
			teacher.students = []

      expect(teacher.has_students?).to eq(false)
    end
  end

  describe "#has_classroom?" do
		it "returns true" do
			teacher.classrooms << classroom

			expect(teacher.has_classroom?(classroom)).to eq(true)
		end

		it "returns false" do
			classroom.teacher = nil
			teacher.classrooms = []
			expect(teacher.has_classroom?(classroom)).to eq(false)
		end
  end

  describe "#has_classrooms?" do
    it "returns true" do
    	teacher.classrooms << classroom

      expect(teacher.has_classrooms?).to eq(true)
    end

    it "returns false" do
      expect(teacher.has_classrooms?).to eq(false)
    end
  end

  describe "#has_classroom_activity?" do
    it "returns true" do
			activity = student1.activities.create(
				action: "funds_one",
				trackable: FactoryGirl.create(:game_stat)
			)

      expect(teacher.has_classroom_activity?).to eq(true)
    end

    it "returns false" do
      expect(teacher.has_classroom_activity?).to eq(false)
    end
  end

  describe "#has_unreviewed_frees?" do
    it "returns true" do
			freestyle = FactoryGirl.create(:freestyle)
			user_word = freestyle.user_word
			student1.user_words << user_word

      expect(teacher.has_unreviewed_frees?).to eq(true)
    end

    it "returns false, if zero freestyles exist" do
      expect(teacher.has_unreviewed_frees?).to eq(false)
    end

    it "returns false, if status is redo" do
			freestyle = FactoryGirl.create(:freestyle, status: "redo")

      expect(teacher.has_unreviewed_frees?).to eq(false)
    end

    it "returns false, if status is pass" do
			freestyle = FactoryGirl.create(:freestyle, status: "pass")

      expect(teacher.has_unreviewed_frees?).to eq(false)
    end
  end
end
