class LookUpWord
	def initialize(query)
		@query = query
	end

	def look_up
		database || api
	end

	private

	attr_reader :query

	def api_word
		@api_word ||= DictionaryAPI::Word.search(query)
	end

	def api
		Word.create!(
			name: query,
			phonetic_spelling: api_word.phonetic_spelling,
			part_of_speech: api_word.part_of_speech,
			definition: api_word.definition,
			example_sentence: api_word.example_sentence
		)
	end

	def database
		word = Word.search(query)

		word.present? ? word : nil
	end
end
