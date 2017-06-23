namespace :words do
  desc "Define all third grade words from Words API"
  task :define_all_third_grade => :environment do
    third = ["ability", "absorb", "accuse", "act", "active", "actual", "adopt", "advantage", "advice", "ambition", "ancient", "approach", "arctic", "arrange", "attitude", "attract", "average", "avoid", "bold", "border", "brief", "brilliant", "cable", "capture", "certain", "chill", "clever", "climate", "cling", "coast", "confess", "consider", "contain", "continent", "convince", "coward", "crew", "crumple", "custom", "decay", "deed", "defend", "delicate", "device", "diagram", "digest", "disease", "distant", "doze", "drift", "elegant", "enable", "examine", "explore", "fan", "fatal", "fierce", "flutter", "fortunate", "frail", "gasp", "glide", "globe", "grace", "gradual", "grasp", "habit", "harsh", "imitate", "individual", "intelligent", "intend", "journey", "launch", "limit", "locate", "loyal", "magnificent", "marsh", "method", "misery", "moisture", "mural", "mystify", "nation", "nectar", "nursery", "observe", "opponent", "opposite", "ordeal", "origin", "outcome", "passage", "pastime", "pause", "perform", "plunge", "predator", "predict", "prevent", "primary", "privilege", "process", "rare", "rate", "recall", "rely", "remark", "resident", "respect", "responsible", "reverse", "revive", "risk", "scatter", "schedule", "sensitive", "signal", "solution", "spoil", "starve", "steer", "struggle", "suitable", "survey", "swift", "symbol", "talent", "theory", "thrill", "treasure", "triumph", "value", "vision", "volunteer", "wander", "wisdom", "wit", "woe"]

    no_good = []
    num_existing_words = 0
    num_errors = 0

    puts "Starting to define 3rd Grade Words:"
    puts

    third.each do |name|
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
