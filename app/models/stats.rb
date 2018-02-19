#****************************
# Aggregate Stats for Leksi
#****************************

# Number of Logins
User.sum(:num_logins)

# Users Without Words
User.select { |u| u.num_words == 0 }.count
User.where.not(id: UserWord.select(:user_id).uniq).count

# Users With Words
User.select { |u| u.num_words > 0 }.count
User.where(id: UserWord.select(:user_id).uniq).count

# Users Without Tags
User.select { |u| u.tags.count == 0 }.count
User.where.not(id: UserTag.select(:user_id).uniq).count

# Users With Tags
User.select { |u| u.tags.count > 0 }.count
User.where(id: UserTag.select(:user_id).uniq).count

# Display latest feedback
#Feedback.all.map { |f| "#{f.user.username} submitted \'#{f.description}\' #{helper.time_ago_in_words(f.created_at)} ago." }.each { |i| puts i }
