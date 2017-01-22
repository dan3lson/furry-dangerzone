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
					"X-Mashape-Key" => "jxec7LMiQymshHsPPG7i86q1rdXNp1Ndvi0jsnTSbYjDIDo0Kk",
					"Accept" => "application/json"
				}
			)

			if response.success? && response[type]
				response[type].map do |w|
					has_multiple_words = w.split(" ").count > 1
					WordsApi.define(w) unless has_multiple_words
				end.flatten
			else
				nil
			end
		rescue => e
			if e.message.include?("Failed to open TCP connection")
				"Looks like you are offline. Come back when you get wifi!"
			end
		end
  end
end
