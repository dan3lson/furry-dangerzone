require 'rails_helper'

RSpec.describe Classroom, type: :model do
    let(:classroom) { FactoryGirl.create(:classroom) }
    let(:student1) { FactoryGirl.create(:student) }

    describe "#has_students?" do
        it "returns true" do
            classroom.students << student1

            expect(classroom.has_students?).to eq(true)
        end

        it "returns false" do
            expect(classroom.has_students?).to eq(false)
        end
    end

    describe "#num_students" do
        it "returns the number of students" do
            student2 = FactoryGirl.create(:student)
            classroom.students << student1 << student2

            expect(classroom.num_students.class).to eq(Fixnum)
            expect(classroom.num_students).to eq(2)
        end
    end
end
