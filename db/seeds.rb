Rails.logger.info "==============================================="
Rails.logger.info "Creating Users"
Rails.logger.info "==============================================="

@founder = User.create!(
  username: "dan3lson",
  password: "danelson",
  password_confirmation: "danelson",
  role: "admin",
  email: ""
)
Rails.logger.info "Username: #{@founder.username}"

7.times do
  user = User.create!(
    username: Faker::Internet.user_name,
    password: "password",
    password_confirmation: "password",
    email: ""
  )
  Rails.logger.info "Username: #{user.username}"
end

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
  description: "Unleash your creativity."
)

Rails.logger.info "==============================================="
Rails.logger.info "Creating Version"
Rails.logger.info "==============================================="

Version.create!(number: "0.0.1", description: "* Making\n * Moves")

Rails.logger.info "==============================================="
Rails.logger.info "Define words"
Rails.logger.info "==============================================="

Word.define("trait")
Word.define("bait")
Word.define("slate")
Word.define("wait")
