namespace :define do
  desc "Define 3rd grade words from list"
  task :third_grade_words => :environment do
    third_grade_words = [
    	"ability",
    	"absorb",
    	"accuse",
    	"act",
    	"active",
    	"actual",
    	"adopt",
    	"advantage",
    	"advice",
    	"ambition",
    	"ancient",
    	"approach",
    	"arrange",
    	"arctic",
    	"attitude",
    	"attract",
    	"average",
    	"avoid",
    	"bold",
    	"border",
    	"brief",
    	"brilliant",
    	"cable",
    	"capture",
    	"certain",
    	"chill",
    	"clever",
    	"climate",
    	"cling",
    	"coast",
    	"confess",
    	"consider",
    	"contain",
    	"continent",
    	"convince",
    	"coward",
    	"crew",
    	"crumple",
    	"custom",
    	"decay",
    	"deed",
    	"defend",
    	"delicate",
    	"device",
    	"diagram",
    	"digest",
    	"disease",
    	"distant",
    	"doze",
    	"drift",
    	"elegant",
    	"enable",
    	"examine",
    	"explore",
    	"fan",
    	"fatal",
    	"fierce",
    	"flutter",
    	"fortunate",
    	"frail",
    	"gasp",
    	"glide",
    	"globe",
    	"grace",
    	"gradual",
    	"grasp",
    	"habit",
    	"harsh",
    	"imitate",
    	"individual",
    	"intelligent",
    	"intend",
    	"journey",
    	"launch",
    	"limit",
    	"locate",
    	"loyal",
    	"magnificent",
    	"marsh",
    	"method",
    	"misery",
    	"moisture",
    	"mural",
    	"mystify",
    	"nation",
    	"nectar",
    	"nursery",
    	"observe",
    	"opponent",
    	"opposite",
    	"ordeal",
    	"origin",
    	"outcome",
    	"passage",
    	"pastime",
    	"pause",
    	"perform",
    	"plunge",
    	"predator",
    	"predict",
    	"prevent",
    	"primary",
    	"privilege",
    	"process",
    	"rare",
    	"rate",
    	"recall",
    	"rely",
    	"remark",
    	"resident",
    	"respect",
    	"responsible",
    	"reverse",
    	"revive",
    	"risk",
    	"scatter",
    	"schedule",
    	"sensitive",
    	"signal",
    	"solution",
    	"spoil",
    	"starve",
    	"steer",
    	"struggled",
    	"suitable",
    	"survey",
    	"swift",
    	"symbol",
    	"talent",
    	"theory",
    	"thrill",
    	"treasure",
    	"triumph",
    	"value",
    	"vision",
    	"volunteer",
    	"wander",
    	"wisdom",
    	"wit",
    	"woe"
    ]
    puts third_grade_words.shuffle.take(50).sort
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
