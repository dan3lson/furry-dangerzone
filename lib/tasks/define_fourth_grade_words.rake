namespace :define do
  desc "Define 4th grade words from list"
  task :fourth_grade_words => :environment do
    fourth_grade_words = [
    	"accurate",
    	"address",
    	"afford",
    	"alert",
    	"analyze",
    	"ancestor",
    	"annual",
    	"apparent",
    	"appropriate",
    	"arena",
    	"arrest",
    	"ascend",
    	"assist",
    	"attempt",
    	"attentive",
    	"attractive",
    	"awkward",
    	"baggage",
    	"basic",
    	"benefit",
    	"blend",
    	"blossom",
    	"burrow",
    	"calculate",
    	"capable",
    	"captivity",
    	"carefree",
    	"century",
    	"chamber",
    	"circular",
    	"coax",
    	"column",
    	"communicate",
    	"competition",
    	"complete",
    	"concentrate",
    	"concern",
    	"conclude",
    	"confuse",
    	"congratulate",
    	"considerable",
    	"content",
    	"contribute",
    	"crafty",
    	"create",
    	"demonstrate",
    	"descend",
    	"desire",
    	"destructive",
    	"develop",
    	"disaster",
    	"disclose",
    	"distract",
    	"distress",
    	"dusk",
    	"eager",
    	"ease",
    	"entertain",
    	"entire",
    	"entrance",
    	"envy",
    	"essential",
    	"extraordinary",
    	"flexible",
    	"focus",
    	"fragile",
    	"frantic",
    	"frequent",
    	"frontier",
    	"furious",
    	"generosity",
    	"hail",
    	"hardship",
    	"heroic",
    	"host",
    	"humble",
    	"impact",
    	"increase",
    	"indicate",
    	"inspire",
    	"instant",
    	"invisible",
    	"jagged",
    	"lack",
    	"limb",
    	"limp",
    	"manufacture",
    	"master",
    	"mature",
    	"meadow",
    	"mistrust",
    	"mock",
    	"modest",
    	"noble",
    	"orchard",
    	"outstanding",
    	"peculiar",
    	"peer",
    	"permit",
    	"plead",
    	"plentiful",
    	"pointless",
    	"portion",
    	"practice",
    	"precious",
    	"prefer",
    	"prepare",
    	"proceed",
    	"queasy",
    	"recent",
    	"recognize",
    	"reduce",
    	"release",
    	"represent",
    	"request",
    	"resist",
    	"response",
    	"reveal",
    	"routine",
    	"severe",
    	"shabby",
    	"shallow",
    	"sole",
    	"source",
    	"sturdy",
    	"surface",
    	"survive",
    	"terror",
    	"threat",
    	"tidy",
    	"tour",
    	"tradition",
    	"tragic",
    	"typical",
    	"vacant",
    	"valiant",
    	"variety",
    	"vast",
    	"venture",
    	"weary"
    ]
    puts fourth_grade_words.shuffle.take(50).sort
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
