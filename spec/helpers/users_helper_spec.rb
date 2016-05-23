require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user_word) { FactoryGirl.create(:user_word) }
  let(:user) { user_word.user }
  let(:word) { user_word.word }
  let(:word_2) { Word.create!(name: "foobar_2", definition: "foobar_2_def") }
  let(:word_3) { Word.create!(name: "foobar_3", definition: "foobar_3_def") }
  let(:word_4) { Word.create!(name: "foobar_4", definition: "foobar_4_def") }
end
