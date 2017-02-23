module Thesaurus
	URL = URI.parse(URI.encode("https://wordsapiv1.p.mashape.com/words"))

	def self.synonyms(name)
    syns_or_ants(name, "synonyms")
	end

	def self.antonyms(name)
    syns_or_ants(name, "antonyms")
	end

  private

  def self.syns_or_ants(name, type)
		begin
			response = HTTParty.get(
				"#{URL}/#{name}/#{type}",
				headers: {
					"X-Mashape-Key" => "jxec7LMiQymshHsPPG7i86q1rdXNp1Ndvi0jsnTSbYjDIDo0Kk",
					"Accept" => "application/json"
				}
			)

			if response.success? && response[type] && !response[type].blank?
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

			nil
		end
  end
end
