require 'rails_helper'

feature "users add the same word", %{

  As a user,
  I want to add a word to myLeksi
  that another use already added.
} do

  # Acceptance Criteria
  #
  # [x] I can see an "add" button for the
  #     word I want
  # [x] myLeksi shows my newly added word
  # [x] I see a message of success

  describe "\n two users add a word" do
    let(:user) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let!(:word) { FactoryGirl.create(:word) }

    pending "scenario: add word" do
      log_in_as(user)

      add_a_word

      visit menu_path

      click_on "Log Out"

      log_in_as(user2)

      add_a_word

      expect(page).to have_content("Awesome - you added \'#{word.name}\'!")
      expect(page).not_to have_content("Yikes!")
      expect(page).to have_content(word.name)
      expect(page).to have_content(word.definition)
      expect(page).to have_content(word.part_of_speech)
      expect(page).to have_content(word.pronunciation)
      expect(UserWord.count).to eq(2)
    end
  end
end
