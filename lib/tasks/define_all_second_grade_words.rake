namespace :words do
  desc "Define all second grade words from Words API"
  task :define_all_second_grade => :environment do
    second = ["accident", "agree", "arrive", "astronomy", "atlas", "attention", "award", "aware", "balance", "banner", "bare", "base", "beach", "besides", "blast", "board", "bounce", "brain", "branch", "brave", "bright", "cage", "calf", "calm", "career", "center", "cheer", "chew", "claw", "clear", "cliff", "club", "collect", "connect", "core", "corner", "couple", "crowd", "curious", "damp", "dangerous", "dash", "dawn", "deep", "demolish", "design", "discard", "dive", "dome", "doubt", "dozen", "earth", "enemy", "evening", "exactly", "excess", "factory", "fair", "famous", "feast", "field", "finally", "flap", "float", "flood", "fold", "fresh", "frighten", "fuel", "gap", "gaze", "gift", "gravity", "greedy", "harm", "herd", "idea", "insect", "instrument", "invent", "island", "leader", "leap", "lizard", "local", "lonely", "luxury", "march", "mention", "motor", "nervous", "net", "nibble", "notice", "ocean", "pack", "pale", "parade", "past", "peak", "planet", "present", "proof", "reflect", "rumor", "safe", "scholar", "seal", "search", "settle", "share", "shelter", "shiver", "shy", "skill", "slight", "smooth", "soil", "stack", "steady", "strand", "stream", "support", "team", "telescope", "tiny", "tower", "travel", "tremble", "universe", "village", "warn", "weak", "wealthy", "whisper", "wise", "wonder", "worry", "yard", "zigzag"]

    no_good = []
    num_existing_words = 0
    num_errors = 0

    puts "Starting to define 2nd Grade Words:"
    puts

    second.each do |name|
    	if Word.word_exists?(name)
    		puts "OK: \'#{name}\' already exists."
    		num_existing_words += 1
    	else
    		words_api_search = WordsApi.new(name).define

    		if words_api_search.class == String
    			puts words_api_search
    			no_good << { name: words_api_search }
          num_errors += 1
    		else
    			words_api_search.each do |new_word|
    				if new_word.save
    					puts "Success for word #{name}(#{new_word.id})"
    				else
    					num_errors += 1
    					puts "ERROR for word #{name}: #{new_word.errors.full_messages}."
    				end
    			end
    		end
    	end
    end

    puts
    puts "Num words that already exist: #{num_existing_words}"
    puts
    puts "BAD WORDS (#{num_errors}): #{no_good}"
    puts
  end
end
