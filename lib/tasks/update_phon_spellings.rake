namespace :phon_spellings do
  desc "Back up all words into a csv"
  task :update => :environment do
    # TODO Update all phonetic spellings with WordsAPI
    # Clearly you have to remove the method; just moved here all to be dealt
    # with later.
    def self.update_phonetic_spellings(limit, offset)
      url = "http://wwww.thefreedictionary.com"

      limit(limit).offset(offset).each do |word|
        page = Nokogiri::HTML(open("#{url}/#{word.name}"))
        phonetic_spellings = page.xpath(
          "//*[@id='Definition']/section[3]/h2"
        )

        next unless phonetic_spellings.any?

        phonetic_spelling = phonetic_spellings.first.text

        if phonetic_spelling =~ /\d/
          phonetic_spelling = phonetic_spelling.gsub(/\d/, ";").split(";").first
        end

        word.phonetic_spelling = phonetic_spelling

        if word.save
          puts "#{word.name} succesfully updated"
        else
          puts "ERROR with #{word.name}"
        end
      end
    end
  end
end
