require 'rails_helper'

feature "guest sends email", %{

  As a guest,
  I want to send an
  email message via
  the contact form.
} do

  # Acceptance Criteria
  #
  # [x] I can see and submit a contact form

  describe "\n admin access admin portal -->" do
    scenario "scenario: activates admin portal" do
      ActionMailer::Base.deliveries.clear

      visit root_path

      fill_in "Name", with: "Total garbage."
      fill_in "Email", with: "Total garbage."
      fill_in "School Name", with: "Total garbage."
      fill_in "Comments", with: "Total garbage."

      find("#cf-submit-btn").click

      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
