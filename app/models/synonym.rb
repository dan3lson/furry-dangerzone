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
    part_of_speech = part_of_speech.gsub(" ", "")


    if response.success?
      response = JSON.parse(response)

      synonyms = if response[part_of_speech]["syn"].blank?
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
