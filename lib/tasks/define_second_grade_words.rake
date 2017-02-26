namespace :define do
  desc "Define 2nd grade words from list"
  task :second_grade_words => :environment do
    second_grade_words = [
    	"acccident",
    	"agree",
    	"arrive",
    	"astronomy",
    	"atlas",
    	"attention",
    	"award",
    	"aware",
    	"balance",
    	"banner",
    	"bare",
    	"base",
    	"beach",
    	"besides",
    	"blast",
    	"board",
    	"bounce",
    	"brain",
    	"branch",
    	"brave",
    	"bright",
    	"cage",
    	"calf",
    	"calm",
    	"career",
    	"center",
    	"cheer",
    	"chew",
    	"claw",
    	"clear",
    	"cliff",
    	"club",
    	"collect",
    	"connect",
    	"core",
    	"corner",
    	"couple",
    	"crowd",
    	"curious",
    	"damp",
    	"dangerous",
    	"dash",
    	"dawn",
    	"deep",
    	"demolish",
    	"design",
    	"discard",
    	"dive",
    	"dome",
    	"doubt",
    	"dozen",
    	"earth",
    	"enemy",
    	"evening",
    	"exactly",
    	"excess",
    	"factory",
    	"fair",
    	"famous",
    	"feast",
    	"field",
    	"finally",
    	"flap",
    	"float",
    	"flood",
    	"fold",
    	"fresh",
    	"frighten",
    	"fuel",
    	"gap",
    	"gaze",
    	"gift",
    	"gravity",
    	"greedy",
    	"harm",
    	"herd",
    	"idea",
    	"insect",
    	"instrument",
    	"invent",
    	"island",
    	"leader",
    	"leap",
    	"lizard",
    	"local",
    	"lonely",
    	"luxury",
    	"march",
    	"mention",
    	"motor",
    	"nervous",
    	"net",
    	"nibble",
    	"notice",
    	"ocean",
    	"pack",
    	"pale",
    	"parade",
    	"past",
    	"peak",
    	"planet",
    	"present",
    	"proof",
    	"reflect",
    	"rumor",
    	"safe",
    	"scholar",
    	"seal",
    	"search",
    	"settle",
    	"share",
    	"shelter",
    	"shiver",
    	"shy",
    	"skill",
    	"slight",
    	"smooth",
    	"soil",
    	"stack",
    	"steady",
    	"strand",
    	"stream",
    	"support",
    	"team",
    	"telescope",
    	"tiny",
    	"tower",
    	"travel",
    	"tremble",
    	"universe",
    	"village",
    	"warn",
    	"weak",
    	"wealthy",
    	"whisper",
    	"wise",
    	"wonder",
    	"worry",
    	"yard",
    	"zigzag"
    ]
    puts second_grade_words.shuffle.take(50).sort
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
