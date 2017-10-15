feature "teacher uploads word photo" do
  scenario "user uploads a profile photo" do
    click_link "Content"
    click_link "Create New Word"

    fill_in "Name", with: "ash@s-mart.com"
    fill_in "Definition", with: "boomstick!3vilisd3ad"
    attach_file :profile_photo, "#{Rails.root}/spec/support/images/photo.png"
    click_button "Create Word"

    expect(page).to have_content("Success!")
    expect(page).to have_css("img[src*='photo.png']")
  end
end
