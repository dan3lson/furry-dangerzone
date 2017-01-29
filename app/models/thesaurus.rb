module Thesaurus
	URL = URI.parse(URI.encode("https://wordsapiv1.p.mashape.com/words"))

	def self.synonyms(word)
    syns_or_ants(word, "synonyms")
	end

	def self.antonyms(word)
    syns_or_ants(word, "antonyms")
	end

  private

  def self.syns_or_ants(word, type)
		begin
			response = HTTParty.get(
				"#{URL}/#{word}/#{type}",
				headers: {
					"X-Mashape-Key" => "Djxec7LMiQymshHsPPG7i86q1rdXNp1Ndvi0jsnTSbYjDIDo0Kk",
					"Accept" => "application/json"
				}
			)

			if response.success? && response[type]
				response[type]
			else
				nil
			end
		rescue => e
			if e.message.include?("Failed to open TCP connection")
				"Looks like you are offline. Come back when you get wifi!"
			else
				"Error in retrieving Thesaurus. Details: #{e.message}."
			end
		end
  end
end
