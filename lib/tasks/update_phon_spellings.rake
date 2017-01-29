namespace :update do
  desc "Update all words with correct phonetic spelling."
  task :phonetic_spellings => :environment do
    names = Word.all.group_by(&:name)

    names.each do |name, array|
      next if name.include?("-") || name.split(" ").count > 1
      
      if array.first.phonetic_spelling
        next if array.first.phonetic_spelling.include?("·")
        syllable_word = WordsApi.new(name).syllables
        words = Word.where(name: name)
        words_count = words.count
        count = words.update_all(phonetic_spelling: syllable_word)
        puts words_count == count ? "Success: #{name}" : "ERROR: #{name}"
      end
    end

    Word.where("name like ?", "%-%").update_all(phonetic_spelling: nil)
    Word.where(phonetic_spelling: nil)
        .each { |w| w.update_attributes(
          phonetic_spelling: WordsApi.new(w.name).syllables
          )
        }
  end
end
