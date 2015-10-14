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
      usernames = %w(
        22annenberg
        22bloch
        22chawla
        22kellner
        22musso
        22nino
        22parr
        22pass
        22riordan
        22seldman
        22spencer
        22sriram
        22tarta
        22vail
        22watts
        22yamazaki
        22zenkerc
        22ball
        22bugdaycay
        22caiola
        22earle
        22friedman
        22gott
        22gund-morrow
        22halverstadt
        22juneja
        22luard
        22palladino
        22pratofiorito
        22ragins
        22tartj
        22weber
        22zenkerm
      )

      usernames.each do |u|
        s = User.new
        s.username = u
        s.password = "password"
        s.password_confirmation = "password"
        s.role = "student"
        s.email = ""
        s.save
      end

      visit root_path

      log_in_as(teacher)

      visit "/school/classrooms"

      expect(page).to have_content("Classes")
      expect(page).to have_link("Home")
      expect(page).to have_link("Review")
      expect(page).to have_link("Progress")
      expect(page).to have_link("Menu")
    end
  end
end
