class WordsApi
	attr_accessor :definition
	attr_accessor :examples
	attr_accessor :part_of_speech
	attr_accessor :phonetic_spelling

	URL = URI.parse(URI.encode("https://wordsapiv1.p.mashape.com/words"))

	def initialize(definition, examples, part_of_speech, phonetic_spelling)
		@definition = definition
		@examples = examples
		@part_of_speech = part_of_speech
		@phonetic_spelling = phonetic_spelling
	end

	def self.define(word)
		response = HTTParty.get("#{URL}/#{word}",
			headers: {
				"X-Mashape-Key" => "jxec7LMiQymshHsPPG7i86q1rdXNp1Ndvi0jsnTSbYjDIDo0Kk",
				"Accept" => "application/json"
			}
		)
		words = []
		if response.success? && response["results"]
			various_words = response["results"]

			various_words.each do |word|
				syllables = response["syllables"]
				joined_syllables = syllables["list"].join("·") if syllables
				new_word = self.new(
					word["definition"],
					word["examples"],
					word["partOfSpeech"],
					joined_syllables
				)
				words << new_word
			end

			words
		else
			nil
		end
	end
end
