require 'rails_helper'

feature "teacher views Classes", %{

  As a teacher,
  I want to see my Classes.
} do

  # Acceptance Criteria
  #
  # [x] I see a Classes link to see my classes
  # [x] If I click on a Class name, I can see
  #    students belonging to that class

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
        s = Student.new
        s.username = u
        s.password = "password"
        s.password_confirmation = "password"
        s.type = "student"
        s.email = ""
        s.save
      end

      visit root_path

      log_in_as(teacher)

      visit "/school/classes"

      expect(page).to have_content("Classes")
      expect(page).to have_link("Review")
      expect(page).to have_link("Stats")
      expect(page).to have_link("Menu")
    end
  end
end
