namespace :words do
  desc "Back up all words into a csv"
  task :backup => :environment do
    CSV.open("./db/data/words_backup.csv", "w") do |row|
      Word.all.each do |word|
        row << [
          word.name,
          word.phonetic_spelling,
          word.definition,
          word.part_of_speech,
          word.example_sentence
        ]
      end
    end
  end
end
