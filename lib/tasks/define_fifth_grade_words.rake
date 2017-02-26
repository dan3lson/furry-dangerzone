namespace :define do
  desc "Define 5th grade words from list"
  task :fifth_grade_words => :environment do
    fifth_grade_words = [
    	"abolish",
    	"dedicate",
    	"absurd",
    	"deprive",
    	"abuse",
    	"detect",
    	"access",
    	"dictate",
    	"accomplish",
    	"document",
    	"achievement",
    	"duplicate",
    	"aggressive",
    	"alternate",
    	"edible",
    	"altitude",
    	"endanger",
    	"antagonist",
    	"escalate",
    	"antonym",
    	"evade",
    	"anxious",
    	"exasperate",
    	"apparent",
    	"excavate",
    	"approximate",
    	"exert",
    	"aroma",
    	"exhibit",
    	"assume",
    	"exult",
    	"astound",
    	"available",
    	"feeble",
    	"avalanche",
    	"frigid",
    	"banquet",
    	"gigantic",
    	"beverage",
    	"gorge",
    	"bland",
    	"guardian",
    	"blizzard",
    	"budge",
    	"hazy",
    	"bungle",
    	"hearty",
    	"homonym",
    	"cautiously",
    	"challenge",
    	"identical",
    	"character",
    	"illuminate",
    	"combine",
    	"immense",
    	"companion",
    	"impressive",
    	"crave",
    	"independent",
    	"compassion",
    	"industrious",
    	"compensate",
    	"intense",
    	"comply",
    	"intercept",
    	"compose",
    	"concept",
    	"jubilation",
    	"confident",
    	"convert",
    	"kin",
    	"course",
    	"courteous",
    	"luxurious",
    	"debate",
    	"major",
    	"decline",
    	"miniature",
    	"minor",
    	"mischief",
    	"monarch",
    	"moral",
    	"myth",
    	"narrator",
    	"navigate",
    	"negative",
    	"nonchalant",
    	"numerous",
    	"oasis",
    	"obsolete",
    	"occasion",
    	"overthrow",
    	"pardon",
    	"pasture",
    	"pedestrian",
    	"perish",
    	"petrify",
    	"portable",
    	"prefix",
    	"preserve",
    	"protagonist",
    	"provide",
    	"purchase",
    	"realistic",
    	"reassure",
    	"reign",
    	"reliable",
    	"require",
    	"resemble",
    	"retain",
    	"retire",
    	"revert",
    	"route",
    	"saunter",
    	"seldom",
    	"senseless",
    	"sever",
    	"slither",
    	"sluggish",
    	"soar",
    	"solitary",
    	"solo",
    	"sparse",
    	"spurt",
    	"strategy",
    	"suffix",
    	"suffocate",
    	"summit",
    	"suspend",
    	"synonym",
    	"talon",
    	"taunt",
    	"thrifty",
    	"translate",
    	"tropical",
    	"visible",
    	"visual",
    	"vivid",
    	"wilderness",
    	"withdraw"
    ]
    puts fifth_grade_words.shuffle.take(50).sort
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
