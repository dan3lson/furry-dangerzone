require 'rails_helper'

feature "teacher views Classrooms", %{

  As a teacher,
  I want to see my Classrooms and
  student progress by clicking on their name.
} do

  # Acceptance Criteria
  #
  # [x] I see a Classrooms link to see my students
  # [x] If I click on a student's name, I can see
  #    their progress

  describe "\n visit menu page -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:teacher) { FactoryGirl.create(:user, role: "teacher") }

    scenario "scenario: teacher sees link to their classroom" do
      visit root_path

      log_in_as(teacher)

      visit menu_path

      expect(page).to have_link("View My Classrooms")
    end
  end
end
