require 'rails_helper'

feature "user adds a word", %{

  As a user,
  I want to add a word to myLeksi.
} do

  # Acceptance Criteria
  #
  # [x] I can see an "add" button for the
  #     word I want
  # [x] myLeksi shows my newly added word
  # [x] I see a message of success

  describe "\n user adds a word" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:word) { FactoryGirl.create(:word) }

    scenario "scenario: add word" do
      log_in_as(user)

      add_a_word
      
      expect(page).to have_content("Awesome - you added #{word.name}!")
      expect(page).not_to have_content("Yikes!")
      expect(page).to have_content(word.name)
      expect(page).to have_content(word.definition)
      expect(page).to have_content(word.part_of_speech)
      expect(page).to have_content(word.pronunciation)
      expect(UserWord.count).to eq(1)
    end
  end
end
