class WordsApi
	attr_accessor :phonetic_spelling
	attr_accessor :part_of_speech
	attr_accessor :definition
	attr_accessor :example_sentence

	def initialize(
		phonetic_spelling,
		part_of_speech,
		definition,
		example_sentence
	)
		@phonetic_spelling = phonetic_spelling
		@part_of_speech = part_of_speech
		@definition = definition
		@example_sentence = example_sentence
	end

	def self.define(word)
		response = HTTParty.get(
			"https://wordsapiv1.p.mashape.com/words/#{word}",
			headers: {
				"X-Mashape-Key" => "vUKklAfkqMmshfX8yZfZ65uhXlvnp1MBDtejsnhSKRB3G7MBR4",
				"Accept" => "application/json"
			}
		)
		binding.pry
		if response.code == 200
			# TODO: Create example_sentences table for better DB design/flexibility
			words = []

			response["results"].each do |word_info|
				phonetic_spelling = response["syllables"]["list"].join("·")
				part_of_speech = word_info["partOfSpeech"]
				definition = word_info["definition"]
				example_sentence = word_info["examples"]

				words << self.new(
					word.phonetic_spelling = phonetic_spelling,
					word.part_of_speech = part_of_speech,
					word.definition = definition,
					word.example_sentence = example_sentence
				)
			end

			words
		end
	end

end
