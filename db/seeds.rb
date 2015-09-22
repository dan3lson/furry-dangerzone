Rails.logger.info "==============================================="
Rails.logger.info "Creating Users"
Rails.logger.info "==============================================="

@founder = User.create!(
  username: "dan3lson",
  password: "danelson",
  password_confirmation: "danelson",
  role: "admin"
)
Rails.logger.info "Username: #{@founder.username}"

7.times do
  user = User.create!(
    username: Faker::Internet.user_name,
    password: "password",
    password_confirmation: "password"
  )
  Rails.logger.info "Username: #{user.username}"
end

Rails.logger.info "==============================================="
Rails.logger.info "Creating Levels"
Rails.logger.info "==============================================="

Level.create!(
  focus: "Spelling",
  direction: "Type the word below:"
)
Level.create!(
  focus: "Checkpoint",
  direction: "Spell the word in order."
)
Level.create!(
  focus: "Pronunciation",
  direction: "Say \'foobar\' aloud and then hit the mic."
)
Level.create!(
  focus: "Meanings",
  direction: "\'foobar\' can have different meanings depending on how you use it."
)
Level.create!(
  focus: "Synonyms",
  direction: "The words below are similar to \'foobar\'."
)
Level.create!(
  focus: "Antonyms",
  direction: "The words below are opposite to \'foobar\'."
)
Level.create!(
  focus: "Checkpoint",
  direction: "Is \'foobar\' a synonym or antonym to:"
)
Level.create!(
  focus: "Real-world Examples",
  direction: "See how \'foobar\' has been used in everyday life."
)
Level.create!(
  focus: "Focus 1",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 2",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 3",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 4",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 5",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 6",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 7",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 8",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 9",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 10",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 11",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 12",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 13",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 14",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 15",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 16",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 17",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 18",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 19",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(
  focus: "Focus 20",
  direction: "Tap one of the four words to match the statement in the middle."
)
Level.create!(focus: "Semantic Map 1", direction: "Type a similar word.")
Level.create!(focus: "Semantic Map 2", direction: "Type a similar word.")
Level.create!(focus: "Semantic Map 3", direction: "Type a similar word.")
Level.create!(focus: "Word Map 1", direction: "What word can be formed?")
Level.create!(focus: "Word Map 2", direction: "What word can be formed?")
Level.create!(focus: "Word Map 3", direction: "What word can be formed?")
Level.create!(
  focus: "Definition Map 1", direction: "What do you think the word means?"
)
Level.create!(
  focus: "Definition Map 2", direction: "What do you think the word means?"
)
Level.create!(
  focus: "Definition Map 3", direction: "What do you think the word means?"
)
Level.create!(
  focus: "Example Sentence 1",
  direction: "Create a sentence with the word in it."
)
Level.create!(
  focus: "Example Sentence 2",
  direction: "Create a sentence with the word in it."
)
Level.create!(
  focus: "Example Sentence 3",
  direction: "Create a sentence with the word in it."
)

Rails.logger.info "==============================================="
Rails.logger.info "Creating Games"
Rails.logger.info "==============================================="

Game.create!(
  name: "Fundamentals",
  description: "Your road to mastery begins with understanding the basics."
)

Game.create!(
  name: "Jeopardy",
  description: "Jeopardy like you\'ve never seen it before."
)

Game.create!(
  name: "Freestyle",
  description: "It\'s time to be creative."
)

Rails.logger.info "==============================================="
Rails.logger.info "Creating Game Levels"
Rails.logger.info "==============================================="

fundamentals_levels = Level.all.take(8)
fundamentals = Game.find_by(name: "Fundamentals")

fundamentals_levels.each do |level|
  GameLevel.create!(
    game: fundamentals,
    level: level
  )
end

jeopardy_levels = Level.all.drop(8).take(20)
jeopardy = Game.find_by(name: "Jeopardy")

jeopardy_levels.each do |level|
  GameLevel.create!(
    game: jeopardy,
    level: level
  )
end

freestyle_levels = Level.all.drop(28)
freestyle = Game.find_by(name: "Freestyle")

freestyle_levels.each do |level|
  GameLevel.create!(
    game: freestyle,
    level: level
  )
end

Rails.logger.info "==============================================="
Rails.logger.info "Creating Version"
Rails.logger.info "==============================================="

Version.create!(number: "0.0.1", description: "* Making\n * Moves")

Rails.logger.info "==============================================="
Rails.logger.info "Define a word"
Rails.logger.info "==============================================="

Word.define("reset")
