Rails.logger.info "==============================================="
Rails.logger.info "Creating Users"
Rails.logger.info "==============================================="

@founder = User.create!(
  username: "dan3lson",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  email: "danelson@leksi.education"
)
Rails.logger.info "Username: #{@founder.username}"

7.times do
  user = User.create!(
    username: Faker::Internet.user_name,
    password: "password",
    password_confirmation: "password",
    email: Faker::Internet.email
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

Rails.logger.info "==============================================="
Rails.logger.info "Creating Blog Posts"
Rails.logger.info "==============================================="

BlogPost.create!(
  title: "All About Leksi, Part 1: What\'s in a Name?",
  content: "Content for All About Leksi Part 1",
  icon: "map-o",
  slug: "all_about_leksi_part_1"
)
BlogPost.create!(
  title: "All About Leksi, Part 2: Our Founder\'s Aha Moment",
  content: "Content for All About Leksi Part 2",
  icon: "lightbulb-o",
  slug: "all_about_leksi_part_2"
)
