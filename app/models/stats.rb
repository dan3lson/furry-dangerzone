# Users Without Words
User.all.map { |u| u.words.count == 0 }.keep_if { |v| v == true }.count

# Users With Words
User.all.map { |u| u.words.count > 0 }.keep_if { |v| v == true }.count

# Users Without Tags
User.all.map { |u| u.tags.count == 0 }.keep_if { |v| v == true }.count

# Users With Tags
User.all.map { |u| u.tags.count > 0 }.keep_if { |v| v == true }.count

# Fundamentals Completed
UserWord.all.map { |uw| uw.fundamentals_completed? }.keep_if { |v| v == true }.count

# Fundamentals In Progress
UserWord.all.map { |uw| uw.fundamentals_in_progress? }.keep_if { |v| v == true }.count

# Fundamentals Not Started
UserWord.all.map { |uw| uw.fundamentals_not_started? }.keep_if { |v| v == true }.count
