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
