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

2.times do
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

Level.all.each do |level|
  GameLevel.create!(
    game: Game.find_by(name: "Fundamentals"),
    level: level
  )
end

Rails.logger.info "==============================================="
Rails.logger.info "Creating Version"
Rails.logger.info "==============================================="

Version.create!(number: "1.1.0", description: "* Making\n * Moves")
