namespace :words do
  desc "Import the words from words_backup.csv into the words table."
  task :import_backup => :environment do
    CSV.foreach("./db/data/words_backup.csv", headers: true) do |row|
      Word.create!(
        name: row[0],
        phonetic_spelling: row[1],
        definition: row[2],
        part_of_speech: row[3],
        example_sentence: row[4]
      )
    end
  end
end
