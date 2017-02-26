namespace :define do
  desc "Define 6th grade words from list"
  task :sixth_grade_words => :environment do
    sixth_grade_words = [
    	"abandon",
    	"constant",
    	"abundant",
    	"contaminate",
    	"access",
    	"context",
    	"accommodate",
    	"continuous",
    	"accumulate",
    	"controversy",
    	"adapt",
    	"convenient",
    	"adhere",
    	"cope",
    	"agony",
    	"cordial",
    	"allegiance",
    	"cultivate",
    	"ambition",
    	"cumulative",
    	"ample",
    	"anguish",
    	"declare",
    	"anticipate",
    	"deluge",
    	"anxious",
    	"dense",
    	"apparel",
    	"deplete",
    	"appeal",
    	"deposit",
    	"apprehensive",
    	"designate",
    	"arid",
    	"desperate",
    	"arrogant",
    	"deteriorate",
    	"awe",
    	"dialogue",
    	"diligent",
    	"barren",
    	"diminish",
    	"beacon",
    	"discretion",
    	"beneficial",
    	"dissent",
    	"blunder",
    	"dissolve",
    	"boisterous",
    	"distinct",
    	"boycott",
    	"diversity",
    	"burden",
    	"domestic",
    	"dominate",
    	"campaign",
    	"drastic",
    	"capacity",
    	"duration",
    	"capital",
    	"dwell",
    	"chronological",
    	"civic",
    	"eclipse",
    	"clarity",
    	"economy",
    	"collaborate",
    	"eerie",
    	"collide",
    	"effect",
    	"commend",
    	"efficient",
    	"commentary",
    	"elaborate",
    	"compact",
    	"eligible",
    	"composure",
    	"elude",
    	"concise",
    	"encounter",
    	"consent",
    	"equivalent",
    	"consequence",
    	"erupt",
    	"conserve",
    	"esteem",
    	"conspicuous",
    	"evolve",
    	"exaggerate",
    	"majority",
    	"excel",
    	"makeshift",
    	"exclude",
    	"manipulate",
    	"expanse",
    	"marvel",
    	"exploit",
    	"massive",
    	"extinct",
    	"maximum",
    	"extract",
    	"meager",
    	"mere",
    	"factor",
    	"migration",
    	"former",
    	"mimic",
    	"formulates",
    	"minute",
    	"fuse",
    	"monotonous",
    	"futile",
    	"negotiate",
    	"generate",
    	"genre",
    	"objective",
    	"obstacle",
    	"habitat",
    	"omniscient",
    	"hazardous",
    	"onset",
    	"hoax",
    	"optimist",
    	"hostile",
    	"originate",
    	"idiom",
    	"painstaking",
    	"ignite",
    	"paraphrase",
    	"immense",
    	"parody",
    	"improvises",
    	"persecute",
    	"inept",
    	"plummet",
    	"inevitable",
    	"possess",
    	"influence",
    	"poverty",
    	"ingenious",
    	"precise",
    	"innovation",
    	"predicament",
    	"intimidate",
    	"predict",
    	"prejudice",
    	"jovial",
    	"preliminary",
    	"primitive",
    	"knack",
    	"priority",
    	"prominent",
    	"leeway",
    	"propel",
    	"prosecute",
    	"legislation",
    	"vow"
    ]
    puts sixth_grade_words.shuffle.take(50).sort
  end
  #   num_errors = 0
  #
  #   first_grade_words.each do |name|
  #     puts name
  #     new_words = WordsApi.define(name)
  #
  #     if new_words.nil?
  #       puts "NOT FOUND: #{name}"
  #     else
  #       words = []
  #
  #       new_words.each do |w|
  #         word = Word.new(
  #             name: name,
  #             phonetic_spelling: w.phonetic_spelling,
  #             part_of_speech: w.part_of_speech,
  #             definition: w.definition
  #           )
  #
  #         if w.examples
  #           if w.examples.count > 1
  #             text = w.examples.join("***")
  #           else
  #             text = w.examples.first
  #           end
  #
  #           example = Example.new(text: text, word: word)
  #           word.examples << example
  #         end
  #
  #         if word.save
  #           puts "Success for word #{name}(#{word.id})"
  #         else
  #           num_errors += 1
  #           puts "ERROR for word #{name}."
  #         end
  #       end
  #     end
  #   end
  #   puts
  #   puts "TOTAL ERRORS: #{num_errors}"
  # end
end
