namespace :update do
  desc "Update all words with slashes to correct phonetic spelling."
  task :phonetic_spellings => :environment do
    names = Word.where("phonetic_spelling LIKE ?", "%/%").pluck(:name).uniq

    names.each do |name|
      syllable_word = WordsApi.new(name).syllables
      words = Word.where(name: name)
      words_count = words.count
      updated_count = words.update_all(phonetic_spelling: syllable_word)
      puts words_count == updated_count ? "Success: #{name}" : "ERROR: #{name}"
    end
  end
end
