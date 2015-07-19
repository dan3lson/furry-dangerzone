Rails.logger.info "==============================================="
Rails.logger.info "Creating Sources"
Rails.logger.info "==============================================="

source = Source.create!(name: "Untagged")
Rails.logger.info "Source: #{source.name}"

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
Rails.logger.info "Creating UserSources"
Rails.logger.info "==============================================="

User.all.each do |user|
  user_source = UserSource.create!(user: user, source: source)
  Rails.logger.info "Source: #{source.name} User: #{user_source.user}"
end
