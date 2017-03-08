namespace :define do
  desc "Define 7th grade words from list"
  task :seventh_grade_words => :environment do
    seventh_grade_words = [
      "abate",
      "catastrophe",
      "abnormal",
      "cater",
      "abode",
      "chorus",
      "abrupt",
      "citrus",
      "accelerate",
      "clamber",
      "acclaim",
      "climax",
      "acknowledge",
      "compromise",
      "acquire",
      "concur",
      "aspire",
      "confront",
      "acrid",
      "congested",
      "addict",
      "conjure",
      "adjacent",
      "consult",
      "admonish",
      "corrupt",
      "affliction",
      "counterfeit",
      "agitate",
      "covet",
      "ajar",
      "customary",
      "akin",
      "allege",
      "debut",
      "annihilate",
      "deceased",
      "anonymous",
      "dependent",
      "antagonize",
      "despondent",
      "apathy",
      "detach",
      "arbitrate",
      "devour",
      "astute",
      "dishearten",
      "authentic",
      "dismal",
      "avert",
      "dismantle",
      "flaw",
      "fruitless",
      "gaudy",
      "geography",
      "gratify",
      "gravity",
      "grim",
      "grimy",
      "grueling",
      "gruesome",
      "haggle",
      "headlong",
      "hilarious",
      "homage",
      "homicide",
      "hospitable",
      "hurtle",
      "hybrid",
      "illiterate",
      "impede",
      "implore",
      "incident",
      "incredulous",
      "melancholy",
      "reprimand",
      "mellow",
      "resume",
      "momentum",
      "retort",
      "mortify",
      "robust",
      "mull",
      "rupture",
      "murky",
      "saga",
      "narrative",
      "sequel",
      "negligent",
      "sham",
      "nimble",
      "shirk",
      "nomadic",
      "simultaneously",
      "noteworthy",
      "snare",
      "notify",
      "species",
      "notorious",
      "status",
      "nurture",
      "stodgy",
      "substantial",
      "obnoxious",
      "subtle",
      "oration",
      "sullen",
      "orthodox",
      "supervise",
      "overwhelm",
      "tamper",
      "pamper",
      "throb",
      "patronize",
      "toxic",
      "peevish",
      "tragedy",
      "pelt",
      "trickle",
      "pending",
      "trivial",
      "perceived",
      "perjury",
      "uncertainty",
      "permanent",
      "unscathed",
      "persist",
      "upright",
      "perturb",
      "urgent",
      "pique",
      "utmost",
      "pluck",
      "poised",
      "vengeance",
      "ponder",
      "vicious",
      "potential",
      "vindictive",
      "predatory",
      "vista",
      "presume",
      "vocation",
      "preview",
      "void",
      "prior",
      "prowess",
      "wary",
      "whim",
      "radiant",
      "wince",
      "random",
      "wrath",
      "rant",
      "recede",
      "yearn",
      "bellow",
      "beseech",
      "downright",
      "maternal",
      "maul",
      "distraught",
      "infamous",
      "exuberant",
      "lurk"
    ]
    num_errors = 0

    seventh_grade_words.each do |name|
      new_words = WordsApi.define(name)

      if new_words.nil?
        puts "NOT FOUND: #{name}"
      else
        new_words.each do |w|
          word = Word.new(
              name: name,
              phonetic_spelling: w.phonetic_spelling,
              part_of_speech: w.part_of_speech,
              definition: w.definition
            )

          if w.examples
            if w.examples.count > 1
              text = w.examples.join("***")
            else
              text = w.examples.first
            end

            example = Example.new(text: text, word: word)
            word.examples << example
          end

          if word.save
            puts "Success for word #{name}(#{word.id})"
          else
            num_errors += 1
            puts "ERROR for word #{name}."
          end
        end
      end
    end
    puts
    puts "TOTAL ERRORS: #{num_errors}"
  end
end
