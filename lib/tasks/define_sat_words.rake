namespace :define do
  desc "Define SAT words from list"
  task :sat_words => :environment do
    sat_grade_words = [
      "ascetic",
      "assuage",
      "atone",
      "audacious",
      "augment",
      "austere",
      "baleful",
      "bard",
      "battery",
      "belligerent",
      "benevolent",
      "benign",
      "berate",
      "bereft",
      "bide",
      "bilk",
      "blandish",
      "bloated",
      "boisterous",
      "bourgeois",
      "brash",
      "brazen",
      "brumal",
      "brusque",
      "buffet",
      "burgeon",
      "cacophony",
      "cadence",
      "callous",
      "calumny",
      "camaraderie",
      "canvas",
      "capricious",
      "captivate",
      "carouse",
      "cavity",
      "cavort",
      "celestial",
      "chastise",
      "choreographed",
      "circumlocution",
      "circumspect",
      "clairvoyant"
    ]
    num_errors = 0

    sat_grade_words.each do |name|
      puts name
      new_words = WordsApi.new(name).define

      if new_words.nil?
        puts "NOT FOUND: #{name}"
      else
        words = []

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
