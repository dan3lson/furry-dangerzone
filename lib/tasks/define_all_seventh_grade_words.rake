namespace :words do
  desc "Define all seventh grade words from Words API"
  task :define_all_seventh_grade => :environment do
    seventh = ["abate", "abnormal", "abode", "abrupt", "accelerate", "acclaim", "acknowledge", "acquire", "acrid", "addict", "adjacent", "admonish", "affliction", "agitate", "ajar", "akin", "allege", "annihilate", "anonymous", "antagonize", "apathy", "arbitrate", "aspire", "astute", "authentic", "avert", "bellow", "beseech", "bestow", "bewilder", "bigot", "blatant", "bleak", "braggart", "brawl", "browse", "bystander", "candid", "canine", "canny", "capricious", "capsize", "casual", "casualty", "catastrophe", "cater", "chorus", "citrus", "clamber", "climax", "compromise", "concur", "confront", "congested", "conjure", "consult", "corrupt", "counterfeit", "covet", "customary", "debut", "deceased", "dependent", "despondent", "detach", "devour", "dishearten", "dismal", "dismantle", "distraught", "docile", "downright", "drone", "dumbfound", "emblem", "endure", "ensue", "enthrall", "epidemic", "erode", "exuberant", "fathom", "feud", "figment", "firebrand", "flabbergast", "flagrant", "flaw", "fruitless", "gaudy", "geography", "gratify", "gravity", "grim", "grimy", "grueling", "gruesome", "haggle", "headlong", "hilarious", "homage", "homicide", "hospitable", "hurtle", "hybrid", "illiterate", "impede", "implore", "incident", "incredulous", "infamous", "infuriate", "insinuate", "intensified", "inundate", "irate", "lavish", "legacy", "legitimate", "lethal", "loath", "lurk", "magnetic", "magnitude", "maternal", "maul", "melancholy", "mellow", "mirth", "momentum", "mortify", "mull", "murky", "narrative", "negligent", "nimble", "nomadic", "noteworthy", "notify", "notorious", "nurture", "obnoxious", "oration", "orthodox", "overwhelm", "pamper", "patronize", "peevish", "pelt", "pending", "perceived", "perjury", "permanent", "persist", "perturb", "pique", "pluck", "poised", "ponder", "potential", "predatory", "presume", "preview", "prior", "prowess", "quench", "radiant", "random", "rant", "recede", "reprimand", "resume", "retort", "robust", "rupture", "saga", "sequel", "sham", "shirk", "simultaneously", "snare", "species", "status", "stodgy", "substantial", "subtle", "sullen", "supervise", "tamper", "throb", "toxic", "tragedy", "trickle", "trivial", "uncertainty", "unscathed", "upright", "urgent", "utmost", "vengeance", "vicious", "vindictive", "vista", "vocation", "void", "wary", "whim", "wince", "wrath", "yearn"]

    no_good = []
    num_existing_words = 0
    num_errors = 0

    puts "Starting to define 7th Grade Words:"
    puts

    seventh.each do |name|
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
