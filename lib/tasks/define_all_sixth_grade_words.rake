namespace :words do
  desc "Define all sixth grade words from Words API"
  task :define_all_sixth_grade => :environment do
    sixth = ["abandon", "abundant", "access", "accommodate", "accumulate", "adapt", "adhere", "agony", "allegiance", "ambition", "ample", "anguish", "anticipate", "anxious", "apparel", "appeal", "apprehensive", "arid", "arrogant", "awe", "barren", "beacon", "beneficial", "blunder", "boisterous", "boycott", "burden", "campaign", "capacity", "capital", "chronological", "civic", "clarity", "collaborate", "collide", "commend", "commentary", "compact", "composure", "concise", "consent", "consequence", "conserve", "conspicuous", "constant", "contaminate", "context", "continuous", "controversy", "convenient", "cope", "cordial", "cultivate", "cumulative", "declare", "deluge", "dense", "deplete", "deposit", "designate", "desperate", "deteriorate", "dialogue", "diligent", "diminish", "discretion", "dissent", "dissolve", "distinct", "diversity", "domestic", "dominate", "drastic", "duration", "dwell", "eclipse", "economy", "eerie", "effect", "efficient", "elaborate", "eligible", "elude", "encounter", "equivalent", "erupt", "esteem", "evolve", "exaggerate", "excel", "exclude", "expanse", "exploit", "extinct", "extract", "factor", "former", "formulates", "fuse", "futile", "generate", "genre", "habitat", "hazardous", "hoax", "hostile", "idiom", "ignite", "immense", "improvises", "inept", "inevitable", "influence", "ingenious", "innovation", "intimidate", "jovial", "knack", "leeway", "legislation", "leisure", "liberate", "likeness", "linger", "literal", "loathe", "lure", "majority", "makeshift", "manipulate", "marvel", "massive", "maximum", "meager", "mere", "migration", "mimic", "minute", "monotonous", "negotiate", "objective", "obstacle", "omniscient", "onset", "optimist", "originate", "painstaking", "paraphrase", "parody", "persecute", "plummet", "possess", "poverty", "precise", "predicament", "predict", "prejudice", "preliminary", "primitive", "priority", "prominent", "propel", "prosecute", "prosper", "provoke", "pursue", "quest", "recount", "refuge", "reinforce", "reluctant", "remorse", "remote", "resolute", "restrain", "retaliate", "retrieve", "rigorous", "rural", "salvage", "sanctuary", "siege", "significant", "solar", "soothe", "stationary", "stifle", "strive", "subordinate", "subsequent", "superior", "supplement", "swarm", "tangible", "terminate", "terrain", "trait", "transform", "transport", "treacherous", "unanimous", "unique", "unruly", "urban", "vacate", "verdict", "verge", "vibrant", "vital", "vow"]

    no_good = []
    num_existing_words = 0
    num_errors = 0

    puts "Starting to define 6th Grade Words:"
    puts

    sixth.each do |name|
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
