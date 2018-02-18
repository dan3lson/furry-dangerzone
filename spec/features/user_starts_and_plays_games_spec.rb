# require 'rails_helper'
#
# ################
# ### GAME ONE ###
# ################
#
# feature "user starts game one", %{
#
#   As a user,
#   I want to start the first game
#   for one of my words
# } do
#
#   # Acceptance Criteria
#   #
#   # [] I can see a red circle with the
#   #    link "start" in red on the myLeksi
#   #    and /words/:id page
#   # [] Clicking on "start" takes me to
#   #    a start-confirmation page
#   # [] Clicking on "go!" takes me to
#   #    the first level of Game 1
#
#   describe "\n user starts game one -->" do
#     let(:user_word) { FactoryGirl.create(:user_word) }
#     let(:word) { user_word.word }
#     let(:user) { user_word.user }
#
#     scenario "scenario: starts game one via myLeksi" do
#       log_in_as(user)
#
#       add_a_word
#
#       click_on "start"
#
#       click_on "go"
#
#       expect(page).to have_content(word.name)
#     end
#
#     scenario "scenario: starts game one via /words/:id" do
#       log_in_as(user)
#
#       add_a_word
#
#       click_on word.name
#
#       click_on "start"
#
#       click_on "go"
#
#       expect(page).to have_content(word.name)
#     end
#   end
# end
#
# feature "user plays game one", %{
#
#   As a user,
#   I want to play the first game
#   for one of my words
# } do
#
#   # Acceptance Criteria
#   #
#   # [] Clicking on "go!" takes me to
#   #    the first level of Game 1
#   # [] I can complete 8 levels or go back
#   #    to /words/:id
#
#   describe "\n user plays game one -->" do
#     let(:user_word) { FactoryGirl.create(:user_word) }
#     let(:word) { user_word.word }
#     let(:user) { user_word.user }
#
#     scenario "scenario: plays game one w/o stopping" do
#       log_in_as(user)
#
#       start_game_one
#
#       # Level 1
#       fill_in "spell-the-word", with: "chess"
#       click_on "continue"
#
#       # Level 2
#       click_on "c"
#       click_on "h"
#       click_on "e"
#       click_on "s"
#       click_on "s"
#       click_on "continue"
#
#       # Level 3
#       click_on "pronunciation_button"
#       click_on "continue"
#
#       # Level 4
#       click_on "meaning_row_button"
#       click_on "continue"
#
#       # Level 5
#       click_on "synonym_row_button"
#       click_on "continue"
#
#       # Level 6
#       click_on "antonym_row_button"
#       click_on "continue"
#
#       # Level 7
#       click_on "synonym_antonym_checkpoint_button"
#       click_on "continue"
#
#       # Level 8
#       click_on "real_world_example_row_button"
#       click_on "continue"
#
#       expect(page).to have_content("Congratulations!")
#       expect(page).to have_content("You\'ve completed Game 1 for")
#       expect(page).to have_content(word.name)
#       expect(page).to have_content("and earned")
#       expect(page).to have_link("start next game")
#       expect(user_word.game.where(name: "game one").status).to eq("complete")
#       expect(user_word.activities.pluck(:completed).include?(false)).to eq(false)
#     end
#   end
# end
#
# ################
# ### GAME TWO ###
# ################
#
# feature "user starts game two", %{
#
#   As a user,
#   I want to start the second game
#   for one of my words
# } do
#
#   # Acceptance Criteria
#   #
#   # [] I can see an orange circle with the
#   #    link "start" in orange on the myLeksi
#   #    and /words/:id page
#   # [] Clicking on "start" takes me to
#   #    a start-confirmation page
#   # [] Clicking on "go!" takes me to
#   #    the first level of Game 2
#
#   describe "\n user starts game two -->" do
#     let(:user_word1) { FactoryGirl.create(:user_word) }
#     let(:user) { user_word.user }
#     let(:user_word2) { FactoryGirl.create(:user_word, user: user) }
#     let(:user_word3) { FactoryGirl.create(:user_word, user: user) }
#     let(:user_word4) { FactoryGirl.create(:user_word, user: user) }
#     let(:word1) { user_word1.word }
#     let(:word2) { user_word2.word }
#     let(:word3) { user_word3.word }
#     let(:word4) { user_word4.word }
#
#     scenario "scenario: starts game two via myLeksi" do
#       log_in_as(user)
#
#       complete_game_one_for(word1)
#
#       visit notebook_path
#
#       click_on "start"
#
#       click_on "go"
#
#       expect(page).to have_link(word1.name)
#       expect(page).to have_link(word2.name)
#       expect(page).to have_link(word3.name)
#       expect(page).to have_link(word4.name)
#       expect((".progress-bar-custom").count).to eq(20)
#     end
#
#     scenario "scenario: starts game two via /words/:id" do
#       log_in_as(user)
#
#       complete_game_one_for(word1)
#
#       visit notebook_path
#
#       click_on word1.name
#
#       click_on "start"
#
#       click_on "go"
#
#       expect(page).to have_link(word1.name)
#       expect(page).to have_link(word2.name)
#       expect(page).to have_link(word3.name)
#       expect(page).to have_link(word4.name)
#       expect((".progress-bar-custom").count).to eq(20)
#     end
#   end
# end
#
# feature "user plays game two", %{
#
#   As a user,
#   I want to play the second game
#   for one of my words that I already
#   completed for the first game
# } do
#
#   # Acceptance Criteria
#   #
#   # [] Clicking on "go!" takes me to
#   #    the first level of Game 1
#   # [] I can complete 8 levels or go back
#   #    to /words/:id
#
#   describe "\n user plays game two -->" do
#     let(:user_word1) { FactoryGirl.create(:user_word) }
#     let(:user) { user_word.user }
#     let(:user_word2) { FactoryGirl.create(:user_word, user: user) }
#     let(:user_word3) { FactoryGirl.create(:user_word, user: user) }
#     let(:user_word4) { FactoryGirl.create(:user_word, user: user) }
#     let(:word1) { user_word1.word }
#     let(:word2) { user_word2.word }
#     let(:word3) { user_word3.word }
#     let(:word4) { user_word4.word }
#
#     scenario "scenario: plays game two without stopping" do
#       log_in_as(user)
#
#       start_game_two
#
#       20.times do |num|
#         # Game 2: Level num
#         click_on [word, word1, word3, word4].sample
#       end
#
#       expect(page).to have_content("Congratulations!")
#       expect(page).to have_content("You\'ve completed Game 2 for")
#       expect(page).to have_content("the words below")
#       expect(page).to have_content("and earned")
#       expect(page).to have_content(word1.name)
#       expect(page).to have_content(word2.name)
#       expect(page).to have_content(word3.name)
#       expect(page).to have_content(word4.name)
#       expect(page).to have_link("start next game")
#       # user_word1 activity and game status to be updated accordingly
#       # user_word2 activity and game status to be updated accordingly
#       # user_word3 activity and game status to be updated accordingly
#       # user_word4 activity and game status to be updated accordingly
#     end
#   end
# end
#
# ##################
# ### GAME THREE ###
# ##################
#
# feature "user starts game three", %{
#
#   As a user,
#   I want to start the second game
#   for one of my words
# } do
#
#   # Acceptance Criteria
#   #
#   # [] I can see a green circle with the
#   #    link "start" in green on the myLeksi
#   #    and /words/:id page
#   # [] Clicking on "start" takes me to
#   #    a start-confirmation page
#   # [] Clicking on "go!" takes me to
#   #    the first level of Game 3
#
#   describe "\n user starts game three -->" do
#     let(:user_word) { FactoryGirl.create(:user_word) }
#     let(:word) { user_word.word }
#     let(:user) { user_word.user }
#
#     scenario "scenario: starts game three via myLeksi" do
#       log_in_as(user)
#
#       complete_game_one_for(word)
#       complete_game_two_for(word)
#
#       visit notebook_path
#
#       click_on "start"
#
#       click_on "go"
#
#       expect(page).to have_content("Semantic Map")
#       expect(page).to have_content("Type three words")
#       expect(page).to have_content("similar to \'#{word.name}\'")
#       expect((".semantic_map_input").count).to eq(3)
#     end
#
#     scenario "scenario: starts game three via /words/:id" do
#       log_in_as(user)
#
#       complete_game_one_for(word)
#       complete_game_two_for(word)
#
#       visit notebook_path
#
#       click_on word.name
#
#       click_on "start"
#
#       click_on "go"
#
#       expect(page).to have_content("Semantic Map")
#       expect(page).to have_content("Type three words")
#       expect(page).to have_content("similar to \'#{word.name}\'")
#       expect((".semantic_map_input").count).to eq(3)
#     end
#   end
# end
#
# feature "user plays game three", %{
#
#   As a user,
#   I want to play the third game
#   for one of my words that I already
#   completed for the first and second game
# } do
#
#   # Acceptance Criteria
#   #
#   # [] Clicking on "go!" takes me to
#   #    the first level of Game 3
#   # [] I can complete 4 levels or go back
#   #    to /words/:id
#
#   describe "\n user plays game three -->" do
#     let(:user_word) { FactoryGirl.create(:user_word) }
#     let(:word) { user_word.word }
#     let(:user) { user_word.user }
#
#     scenario "scenario: plays game two without stopping" do
#       log_in_as(user)
#
#       start_game_three
#
#       fill_in "first_semantic_map_input", with: "foobar"
#       fill_in "second_semantic_map_input", with: "foobar"
#       fill_in "third_semantic_map_input", with: "foobar"
#       click_on "continue"
#
#       fill_in "first_word_map_input", with: "foobar"
#       fill_in "second_word_map_input", with: "foobar"
#       fill_in "third_word_map_input", with: "foobar"
#       click_on "continue"
#
#       fill_in "first_definition_map_input", with: "foobar"
#       fill_in "second_definition_map_input", with: "foobar"
#       fill_in "third_definition_map_input", with: "foobar"
#       click_on "continue"
#
#       fill_in "first_sentence_input", with: "foobar"
#       fill_in "second_sentence_input", with: "foobar"
#       fill_in "third_sentence_input", with: "foobar"
#       click_on "continue"
#
#       click_on "send for review"
#
#       expect(page).to have_content("Congratulations!")
#       expect(page).to have_content("You\'ve completed Game 3 for")
#       expect(page).to have_content("\'#{word.name}\'")
#       expect(page).to have_content("and earned")
#       expect(user_word.games.where(name: "game three").status).to eq("complete")
#     end
#   end
# end
