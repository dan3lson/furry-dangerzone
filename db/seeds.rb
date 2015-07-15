Rails.logger.info "==============================================="
Rails.logger.info "Creating Users"
Rails.logger.info "==============================================="

User.create!(
  username: "dan3lson",
  password: "danelson",
  password_confirmation: "danelson"
)
10.times do
  user = User.create!(
    username: Faker::Internet.user_name,
    password: "password",
    password_confirmation: "password"
  )
  Rails.logger.info "Username: #{user.username}"
end

Rails.logger.info "==============================================="
Rails.logger.info "Creating Words"
Rails.logger.info "==============================================="

10.times do
  name = Faker::Lorem.word
  word = Word.create!(
    name: name,
    definition: Faker::Company.bs,
    part_of_speech: %w(noun adjective verb adverb).sample,
    phonetic_spelling: name.split.join("-"),
    example_sentence: Faker::Company.bs
  )
  Rails.logger.info "Word: #{word.name} | #{word.definition} |"
  Rails.logger.info "[cont'd]: #{word.part_of_speech} | "
  Rails.logger.info "#{word.phonetic_spelling} | "
  Rails.logger.info "#{word.example_sentence}"
  Rails.logger.info "***"
end
