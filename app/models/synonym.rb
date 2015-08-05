class Synonym
  include HTTParty
  include Nokogiri

  attr_accessor :synonyms

  API_URL = "http://words.bighugelabs.com/api/2"
  API_KEY = ENV["BIG_HUGE_THESAURUS"]

  def initialize
    @synonyms
  end

  def self.provide(word, part_of_speech)
    response = HTTParty.get("#{API_URL}/#{API_KEY}/#{word}/json")

    if response.success?
      part_of_speech[0].gsub(" ","")

      response = JSON.parse(response)

      synonyms = if response[part_of_speech]["syn"].nil?
                   nil
                 else
                   response[part_of_speech]["syn"]
                 end
    else
      Rails.logger.error { "Error: something didn\'t work..." }
      nil
    end
  end
end
