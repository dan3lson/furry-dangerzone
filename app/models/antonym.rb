class Antonym
  include HTTParty
  include Nokogiri

  attr_accessor :antonyms

  API_URL = "http://words.bighugelabs.com/api/2"
  API_KEY = ENV["BIG_HUGE_THESAURUS"]

  def initialize
    @antonyms
  end

  def self.provide(word, part_of_speech)
    response = HTTParty.get("#{API_URL}/#{API_KEY}/#{word}/json")

    if response.success?
      response = JSON.parse(response)

      antonyms = if response[part_of_speech]["ant"].nil?
                   nil
                 else
                   response[part_of_speech]["ant"]
                 end
    else
      Rails.logger.error { "Error: something didn\'t work..." }
      nil
    end
  end
end
