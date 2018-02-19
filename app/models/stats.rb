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

# Fundamentals Completed
UserWord.where.not(games_completed: 0).count

# Num Fundamentals Played
GameStat.where(game_id: 1).sum(:num_played)

# Fundamentals Not Completed
UserWord.where(games_completed: 0).count

# Jeopardys Completed
UserWord.where(games_completed: 2).count +
UserWord.where(games_completed: 3).count

# Num Jeopardys Played
GameStat.where(game_id: 2).sum(:num_played)

# Jeopardys Not Completed
UserWord.select { |uw| uw.jeopardy_not_completed? }.count

# Num Jeopardys Won
GameStat.sum(:num_jeop_won)

# Num Jeopardys Lost
GameStat.sum(:num_jeop_lost)

# Freestyles Completed
UserWord.where(games_completed: 3).count

# Num Freestyles Played
GameStat.where(game_id: 3).sum(:num_played)

# Freestyles Not Completed
UserWord.select { |uw| uw.freestyle_not_completed? }.count

# Display latest feedback
#Feedback.all.map { |f| "#{f.user.username} submitted \'#{f.description}\' #{helper.time_ago_in_words(f.created_at)} ago." }.each { |i| puts i }
