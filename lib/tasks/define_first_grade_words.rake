namespace :define do
  desc "Define 1st grade words from list"
  task :first_grade_words => :environment do
    first_grade_words = [
    	"ache",
    	"adjust",
    	"affordable",
    	"alarm",
    	"alone",
    	"apologize",
    	"appetite",
    	"applause",
    	"artistic",
    	"atmosphere",
    	"attach",
    	"bashful",
    	"basket",
    	"batch",
    	"behave",
    	"belong",
    	"bend",
    	"blink",
    	"blush",
    	"blush",
    	"bolt",
    	"bolts",
    	"borrow",
    	"bundle",
    	"cabin",
    	"caterpillar",
    	"caution",
    	"cave",
    	"celebrate",
    	"centaur",
    	"champion",
    	"chat",
    	"cheat",
    	"chimney",
    	"compass",
    	"complain",
    	"conductor",
    	"construct",
    	"costume",
    	"cozy",
    	"cranky",
    	"crash",
    	"creak",
    	"croak",
    	"crowded",
    	"cue",
    	"curved",
    	"daily",
    	"dainty",
    	"dart",
    	"decorate",
    	"delighted",
    	"denied",
    	"deserve",
    	"divide",
    	"dodge",
    	"drenched",
    	"drowsy",
    	"enormous",
    	"equal",
    	"exclaim",
    	"exhausted",
    	"expensive",
    	"fancy",
    	"fasten",
    	"filthy",
    	"flat",
    	"flee",
    	"fog",
    	"footprint",
    	"forest",
    	"freezing",
    	"gather",
    	"giant",
    	"glad",
    	"gleaming",
    	"glum",
    	"grab",
    	"grateful",
    	"grin",
    	"grip",
    	"groan",
    	"hatch",
    	"heap",
    	"hide",
    	"hobby",
    	"honest",
    	"howl",
    	"illustrator",
    	"injury",
    	"jealous",
    	"knob",
    	"lively",
    	"loosen",
    	"mask",
    	"misty",
    	"modern",
    	"mountain",
    	"narrow",
    	"obey",
    	"pain",
    	"passenger",
    	"pattern",
    	"pest",
    	"polish",
    	"pretend",
    	"promise",
    	"rapid",
    	"remove",
    	"repeat",
    	"rescue",
    	"restart",
    	"return",
    	"ripe",
    	"rise",
    	"roar",
    	"rough",
    	"rusty",
    	"scold",
    	"scratch",
    	"seed",
    	"selfish",
    	"serious",
    	"shell",
    	"shovel",
    	"shriek",
    	"sibling",
    	"silent",
    	"simple",
    	"slippery",
    	"sly",
    	"sneaky",
    	"sob",
    	"spiral",
    	"splendid",
    	"sprinkle",
    	"squirm",
    	"startle",
    	"steep",
    	"stormy",
    	"striped",
    	"surround",
    	"switch",
    	"terrified",
    	"thick",
    	"thunder",
    	"ticket",
    	"timid",
    	"transportation",
    	"travel",
    	"trust",
    	"upset",
    	"weed",
    	"whimper",
    	"whirl",
    	"wicked",
    	"wicked",
    	"yank"
    ]
    puts first_grade_words.shuffle.take(50).sort
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
