require 'rails_helper'

feature "user takes vocabulary knowledge scale (vks)", %{

  As a user,
  I want to take the
  VKS for one of my words.
} do

  # Acceptance Criteria
  #
  # [x] I can see a link to the
  #     VKS page
  # [x] I can see a continue button

  skip "\n user visits vks page -->", js: true do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: click get started button" do
      log_in_as(user)

      visit settings_path

      click_on "Knowledge Scale"

      expect(page).to have_content("Knowledge Scale")
      expect(page).to have_css(".knowledge-scale")
      expect(page).to have_button("Continue", disabled: true)
    end
  end
end
