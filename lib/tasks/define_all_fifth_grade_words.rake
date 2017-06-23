namespace :words do
  desc "Define all fifth grade words from Words API"
  task :define_all_fifth_grade => :environment do
    fifth = ["abolish", "absurd", "abuse", "access", "accomplish", "achievement", "aggressive", "alternate", "altitude", "antagonist", "antonym", "anxious", "apparent", "approximate", "aroma", "assume", "astound", "available", "avalanche", "banquet", "beverage", "bland", "blizzard", "budge", "bungle", "cautiously", "challenge", "character", "combine", "companion", "compassion", "compensate", "comply", "compose", "concept", "confident", "convert", "course", "courteous", "crave", "debate", "decline", "dedicate", "deprive", "detect", "dictate", "document", "duplicate", "edible", "endanger", "escalate", "evade", "exasperate", "excavate", "exert", "exhibit", "exult", "feeble", "frigid", "gigantic", "gorge", "guardian", "hazy", "hearty", "homonym", "identical", "illuminate", "immense", "impressive", "independent", "industrious", "intense", "intercept", "jubilation", "kin", "luxurious", "major", "miniature", "minor", "mischief", "monarch", "moral", "myth", "narrator", "navigate", "negative", "nonchalant", "numerous", "oasis", "obsolete", "occasion", "overthrow", "pardon", "pasture", "pedestrian", "perish", "petrify", "portable", "prefix", "preserve", "protagonist", "provide", "purchase", "realistic", "reassure", "reign", "reliable", "require", "resemble", "retain", "retire", "revert", "route", "saunter", "seldom", "senseless", "sever", "slither", "sluggish", "soar", "solitary", "solo", "sparse", "spurt", "strategy", "suffix", "suffocate", "summit", "suspend", "synonym", "talon", "taunt", "thrifty", "translate", "tropical", "visible", "visual", "vivid", "wilderness", "withdraw"]

    no_good = []
    num_existing_words = 0
    num_errors = 0

    puts "Starting to define 5th Grade Words:"
    puts

    fifth.each do |name|
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
