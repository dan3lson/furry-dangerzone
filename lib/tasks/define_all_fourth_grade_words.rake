namespace :words do
  desc "Define all fourth grade words from Words API"
  task :define_all_fourth_grade => :environment do
    fourth = ["accurate", "address", "afford", "alert", "analyze", "ancestor", "annual", "apparent", "appropriate", "arena", "arrest", "ascend", "assist", "attempt", "attentive", "attractive", "awkward", "baggage", "basic", "benefit", "blend", "blossom", "burrow", "calculate", "capable", "captivity", "carefree", "century", "chamber", "circular", "coax", "column", "communicate", "competition", "complete", "concentrate", "concern", "conclude", "confuse", "congratulate", "considerable", "content", "contribute", "crafty", "create", "demonstrate", "descend", "desire", "destructive", "develop", "disaster", "disclose", "distract", "distress", "dusk", "eager", "ease", "entertain", "entire", "entrance", "envy", "essential", "extraordinary", "flexible", "focus", "fragile", "frantic", "frequent", "frontier", "furious", "generosity", "hail", "hardship", "heroic", "host", "humble", "impact", "increase", "indicate", "inspire", "instant", "invisible", "jagged", "lack", "limb", "limp", "manufacture", "master", "mature", "meadow", "mistrust", "mock", "modest", "noble", "orchard", "outstanding", "peculiar", "peer", "permit", "plead", "plentiful", "pointless", "portion", "practice", "precious", "prefer", "prepare", "proceed", "queasy", "recent", "recognize", "reduce", "release", "represent", "request", "resist", "response", "reveal", "routine", "severe", "shabby", "shallow", "sole", "source", "sturdy", "surface", "survive", "terror", "threat", "tidy", "tour", "tradition", "tragic", "typical", "vacant", "valiant", "variety", "vast", "venture", "weary"]

    no_good = []
    num_existing_words = 0
    num_errors = 0

    puts "Starting to define 4th Grade Words:"
    puts

    fourth.each do |name|
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
