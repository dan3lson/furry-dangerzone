namespace :define do
  desc "Define 8th grade words from list"
  task :eigth_grade_words => :environment do
    eigth_grade_words = [
    	"balmy",
    	"dispatch",
    	"banter",
    	"disposition",
    	"barter",
    	"doctrine",
    	"benign",
    	"dub",
    	"bizarre",
    	"durable",
    	"blasé",
    	"bonanza",
    	"eccentric",
    	"bountiful",
    	"elite",
    	"haven",
    	"heritage",
    	"hindrance",
    	"hover",
    	"humane",
    	"imperative",
    	"cache",
    	"embark",
    	"capacious",
    	"encroach",
    	"caption",
    	"endeavor",
    	"chastise",
    	"enhance",
    	"citadel",
    	"enigma",
    	"cite",
    	"epoch",
    	"clad",
    	"era",
    	"clarify",
    	"eventful",
    	"commemorate",
    	"evolve",
    	"component",
    	"exceptional",
    	"concept",
    	"excerpt",
    	"confiscate",
    	"excruciating",
    	"indifferent",
    	"infinite",
    	"instill",
    	"institute",
    	"intervene",
    	"intricate",
    	"inventive",
    	"inventory",
    	"irascible",
    	"jurisdiction",
    	"connoisseur",
    	"accord",
    	"conscientious",
    	"adept",
    	"￼￼abet",
    	"conservative",
    	"advocate",
    	"contagious",
    	"agile",
    	"conventional",
    	"allot",
    	"convey",
    	"aloof",
    	"crucial",
    	"amiss",
    	"crusade",
    	"analogy",
    	"culminate",
    	"anarchy",
    	"antics",
    	"deceptive",
    	"apprehend",
    	"decipher",
    	"ardent",
    	"decree",
    	"articulate",
    	"deface",
    	"assail",
    	"defect",
    	"assimilate",
    	"deplore",
    	"atrocity",
    	"deploy",
    	"attribute",
    	"desist",
    	"audacious",
    	"desolate",
    	"augment",
    	"deter",
    	"authority",
    	"dialect",
    	"avail",
    	"dire",
    	"avid",
    	"discern",
    	"awry",
    	"disdain",
    	"exemplify",
    	"exotic",
    	"facilitate",
    	"fallacy",
    	"fastidious",
    	"feasible",
    	"fend",
    	"ferret",
    	"flair",
    	"flustered",
    	"foreboding",
    	"forfeit",
    	"formidable",
    	"fortify",
    	"foster",
    	"gaunt",
    	"gingerly",
    	"glut",
    	"grapple",
    	"grope",
    	"gullible",
    	"languish",
    	"renown",
    	"legendary",
    	"revenue",
    	"liberal",
    	"rubble",
    	"loll",
    	"rue",
    	"lucrative",
    	"luminous",
    	"sage",
    	"sedative",
    	"memoir",
    	"serene",
    	"mercenary",
    	"servile",
    	"mien",
    	"shackle",
    	"millennium",
    	"slmien",
    	"shacize",
    	"spontaneous",
    	"modify",
    	"stamina",
    	"stance",
    	"staple",
    	"onslaught",
    	"stint",
    	"sublime",
    	"overt",
    	"subside",
    	"succumb",
    	"pang",
    	"surpass",
    	"panorama",
    	"susceptible",
    	"perspective",
    	"swelter",
    	"phenomenon",
    	"panorama",
    	"perspective",
    	"swelter",
    	"phenomenon",
    	"sporadic",
    	"muse",
    	"muster",
    	"recourse",
    	"wage",
    	"recur",
    	"wrangle",
    	"renounce",
    	"disgruntled",
    	"haggard",
    	"inaugurate",
    	"embargo",
    	"incense"
    ]
    puts eigth_grade_words.shuffle.sort
    # num_errors = 0
    #
    # eigth_grade_words.each do |name|
    #   puts name
    #   new_words = WordsApi.define(name)
    #
    #   if new_words.nil?
    #     puts "NOT FOUND: #{name}"
    #   else
    #     words = []
    #
    #     new_words.each do |w|
    #       word = Word.new(
    #           name: name,
    #           phonetic_spelling: w.phonetic_spelling,
    #           part_of_speech: w.part_of_speech,
    #           definition: w.definition
    #         )
    #
    #       if w.examples
    #         if w.examples.count > 1
    #           text = w.examples.join("***")
    #         else
    #           text = w.examples.first
    #         end
    #
    #         example = Example.new(text: text, word: word)
    #         word.examples << example
    #       end
    #
    #       if word.save
    #         puts "Success for word #{name}(#{word.id})"
    #       else
    #         num_errors += 1
    #         puts "ERROR for word #{name}."
    #       end
    #     end
    #   end
    # end
    # puts
    # puts "TOTAL ERRORS: #{num_errors}"
  end
end
