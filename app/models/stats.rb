# Users With Words
User.all.map { |u| u.words.count > 0 }.keep_if { |v| v == true }.count

# Users Without Words
User.all.map { |u| u.words.count == 0 }.keep_if { |v| v == true }.count

# Users With Tags
User.all.map { |u| u.tags.count > 0 }.keep_if { |v| v == true }.count

# Users Without Tags
User.all.map { |u| u.tags.count == 0 }.keep_if { |v| v == true }.count

# Fundamentals Completed
UserWord.all.map { |uw| uw.fundamentals_completed? }.keep_if { |v| v == true }.count

# Fundamentals In Progress
UserWord.all.map { |uw| uw.fundamentals_in_progress? }.keep_if { |v| v == true }.count

# Fundamentals Not Started
UserWord.all.map { |uw| uw.fundamentals_not_started? }.keep_if { |v| v == true }.count

def baseline_gamification
	User.all.each do |u|
		u.points = 0

		if u.has_words?
			u.points += u.words.count
		end

		if u.has_tags?
			u.points += u.tags.count
		end

		if u.has_user_word_tags?
			u.points += u.user_word_tags.count * 2
		end

		if u.has_completed_fundamentals?
			u.points += u.completed_fundamentals.count * 10
		end

		u.save
	end
end
