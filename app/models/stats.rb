# Number of Logins
User.all.map(&:num_logins).inject(0, &:+)

# Users Without Words
User.select { |u| u.words.count == 0 }.count

# Users With Words
User.select { |u| u.words.count > 0 }.count

# Users Without Tags
User.select { |u| u.tags.count == 0 }.count

# Users With Tags
User.select { |u| u.tags.count > 0 }.count

# Fundamentals Completed
UserWord.select { |uw| uw.fundamental_completed? }.count

# Num Fundamentals Played
GameStat.select { |gs| gs.game_id == 1 }.map(&:num_played).inject(0, &:+)

# Fundamentals In Progress -> DEPRECATED
# UserWord.select { |uw| uw.fundamental_in_progress? }.count

# Fundamentals Not Started
UserWord.select { |uw| uw.fundamental_not_started? }.count

# Jeopardys Completed
UserWord.select { |uw| uw.jeopardy_completed? }.count

# Num Jeopardys Played
GameStat.select { |gs| gs.game_id == 2 }.map(&:num_played).inject(0, &:+)

# Jeopardys Not Started
UserWord.select { |uw| uw.jeopardy_not_started? }.count

# Num Jeopardys Won
GameStat.sum(:num_jeop_won)

# Num Jeopardys Lost
GameStat.sum(:num_jeop_lost)

# Freestyles Completed
UserWord.select { |uw| uw.freestyle_completed? }.count

# Num Freestyles Played
GameStat.select { |gs| gs.game_id == 3 }.map(&:num_played).inject(0, &:+)

# Freestyles Not Started
UserWord.select { |uw| uw.freestyle_not_started? }.count
