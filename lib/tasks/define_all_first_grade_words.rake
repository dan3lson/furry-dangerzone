namespace :words do
  desc "Define all first grade words from Words API"
  task :define_all_first_grade => :environment do
    first = ["ache", "adjust", "affordable", "alarm", "alone", "apologize", "appetite", "applause", "artistic", "atmosphere", "attach", "bashful", "basket", "batch", "behave", "belong", "bend", "blink", "blush", "blush", "bolt", "bolts", "borrow", "bundle", "cabin", "caterpillar", "caution", "cave", "celebrate", "centaur", "champion", "chat", "cheat", "chimney", "compass", "complain", "conductor", "construct", "costume", "cozy", "cranky", "crash", "creak", "croak", "crowded", "cue", "curved", "daily", "dainty", "dart", "decorate", "delighted", "deny", "deserve", "divide", "dodge", "drenched", "drowsy", "enormous", "equal", "exclaim", "exhausted", "expensive", "fancy", "fasten", "filthy", "flat", "flee", "fog", "footprint", "forest", "freezing", "gather", "giant", "glad", "gleaming", "glum", "grab", "grateful", "grin", "grip", "groan", "hatch", "heap", "hide", "hobby", "honest", "howl", "illustrator", "injury", "jealous", "knob", "lively", "loosen", "mask", "misty", "modern", "mountain", "narrow", "obey", "pain", "passenger", "pattern", "pest", "polish", "pretend", "promise", "rapid", "remove", "repeat", "rescue", "restart", "return", "ripe", "rise", "roar", "rough", "rusty", "scold", "scratch", "seed", "selfish", "serious", "shell", "shovel", "shriek", "sibling", "silent", "simple", "slippery", "sly", "sneaky", "sob", "spiral", "splendid", "sprinkle", "squirm", "startle", "steep", "stormy", "striped", "surround", "switch", "terrified", "thick", "thunder", "ticket", "timid", "transportation", "travel", "trust", "upset", "weed", "whimper", "whirl", "wicked", "wicked", "yank"]
    no_good = []
    num_existing_words = 0
    num_errors = 0

    puts "Starting to define 1st Grade Words:"
    puts

    first.each do |name|
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
