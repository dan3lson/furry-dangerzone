class WordsApi
	class NoWordError < StandardError
	end

	def initialize(name)
		@name = name
	end

	def define
		response = self.everything
		words = []
		api_words = response["results"]

		api_words.each do |word|
			syllables = response["syllables"]
			joined_syllables = syllables["list"].join("·") if syllables
			new_word = Word.new(
				name: name,
				definition: word["definition"],
				part_of_speech: word["partOfSpeech"],
				phonetic_spelling: joined_syllables
			)
			examples = word["examples"]

			if examples
				text = examples.count > 1 ? examples.join("***") : examples.first
				example = Example.new(text: text, word: new_word)
				new_word.examples << example
			end

			words << new_word
		end

		words

		rescue
			msg = [
				"Sorry, we didn\'t find '#{name}' from your search. ",
				"Please check the spelling and try again."
			].join
			raise WordsApi::NoWordError, msg
			nil
	end

	def everything
		get_everything
	end

	def syllables
		response = get_everything("syllables")
		return nil if response.class == String ||
									response.code != 200 ||
									response["syllables"].empty?
		response["syllables"]["list"].join("·")
	end

	def examples
		response = get_everything("examples")
		return nil if response.class == String ||
									response.code != 200 ||
									response["examples"].empty?
		response["examples"].join("***")
	end

	private

	attr_reader :name

	def get_everything(specifically_get = nil)
		key = "jxec7LMiQymshHsPPG7i86q1rdXNp1Ndvi0jsnTSbYjDIDo0Kk"

		begin
			HTTParty.get(
				"#{url}/#{name}/#{specifically_get}",
				headers: {
					"X-Mashape-Key" => key,
					"Accept" => "application/json"
				}
			)
		rescue => e
			if e.message.include?("Failed to open TCP connection")
				"Error: Offline; come back when you connect to the Internet!"
			else
				"Error: Accessing Word Info; details: #{e.message}."
			end
		end
	end

	def url
		URI.parse(URI.encode("https://wordsapiv1.p.mashape.com/words"))
	end
end
