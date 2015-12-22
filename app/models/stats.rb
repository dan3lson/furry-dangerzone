#****************************
# Aggregate Stats for Leksi
#****************************

# Number of Logins
User.sum(:num_logins)

# Users Without Words
User.select { |u| u.words.count == 0 }.count

# Users With Words
User.select { |u| u.words.count > 0 }.count

# Users Without Tags
User.select { |u| u.tags.count == 0 }.count

# Users With Tags
User.select { |u| u.tags.count > 0 }.count

# Fundamentals Completed
UserWord.where.not(games_completed: 0).count

# Time Spent Completing Fundamentals
GameStat.where(game_id: 1).sum(:time_spent).to_s

# Num Fundamentals Played
GameStat.where(game_id: 1).sum(:num_played)

# Fundamentals Not Completed
UserWord.where(games_completed: 0).count

# Jeopardys Completed
UserWord.where(games_completed: 2).count +
UserWord.where(games_completed: 3).count

# Time Spent Completing Jeopardys
GameStat.where(game_id: 2).sum(:time_spent).to_s

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

# Time Spent Completing Freestyles
GameStat.where(game_id: 3).sum(:time_spent).to_s

# Num Freestyles Played
GameStat.where(game_id: 3).sum(:num_played)

# Freestyles Not Completed
UserWord.select { |uw| uw.freestyle_not_completed? }.count

# Num Flashcards Played
User.sum(:num_flashcards_played)

# Display latest feedback
#Feedback.all.map { |f| "#{f.user.username} submitted \'#{f.description}\' #{helper.time_ago_in_words(f.created_at)} ago." }.each { |i| puts i }
