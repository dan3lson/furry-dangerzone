namespace :words do
  desc "Define all eigth grade words from Words API"
  task :define_all_eigth_grade => :environment do
    eigth = ["abet", "accord", "adept", "advocate", "agile", "allot", "aloof", "amiss", "analogy", "anarchy", "antic", "apprehend", "ardent", "articulate", "assail", "assimilate", "atrocity", "attribute", "audacious", "augment", "authority", "avail", "avid", "awry", "balmy", "banter", "barter", "benign", "bizarre", "blase", "bonanza", "bountiful", "cache", "capacious", "caption", "chastise", "citadel", "cite", "clad", "clarify", "commemorate", "component", "concept", "confiscate", "connoisseur", "conscientious", "conservative", "contagious", "conventional", "convey", "crucial", "crusade", "culminate", "deceptive", "decipher", "decree", "deface", "defect", "deplore", "deploy", "desist", "desolate", "deter", "dialect", "dire", "discern", "disdain", "disgruntled", "dispatch", "disposition", "doctrine", "dub", "durable", "eccentric", "elite", "embargo", "embark", "encroach", "endeavor", "enhance", "enigma", "epoch", "era", "eventful", "evolve", "exceptional", "excerpt", "excruciating", "exemplify", "exotic", "facilitate", "fallacy", "fastidious", "feasible", "fend", "ferret", "flair", "flustered", "foreboding", "forfeit", "formidable", "fortify", "foster", "gaunt", "gingerly", "glut", "grapple", "grope", "gullible", "haggard", "haven", "heritage", "hindrance", "hover", "humane", "imperative", "inaugurate", "incense", "indifferent", "infinite", "instill", "institute", "intervene", "intricate", "inventive", "inventory", "irascible", "jurisdiction", "languish", "legendary", "liberal", "loll", "lucrative", "luminous", "memoir", "mercenary", "mien", "millennium", "minimize", "modify", "muse", "muster", "onslaught", "ornate", "ovation", "overt", "pang", "panorama", "perspective", "phenomenon", "pioneer", "pithy", "pivotal", "plausible", "plunder", "porous", "preposterous", "principal", "prodigy", "proficient", "profound", "pseudonym", "pungent", "rankle", "rational", "rebuke", "reception", "recourse", "recur", "renounce", "renown", "revenue", "rubble", "rue", "sage", "sedative", "serene", "servile", "shackle", "sleek", "spontaneous", "sporadic", "stamina", "stance", "staple", "stint", "strident", "sublime", "subside", "succumb", "surpass", "susceptible", "swelter", "tedious", "teem", "theme", "tirade", "tract", "transition", "trepidation", "turbulent", "tycoon", "ultimate", "ungainly", "vie", "vilify", "voracious", "wage", "wrangle"]

    no_good = []
    num_existing_words = 0
    num_errors = 0

    puts "Starting to define 8th Grade Words:"
    puts

    eigth.each do |name|
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
