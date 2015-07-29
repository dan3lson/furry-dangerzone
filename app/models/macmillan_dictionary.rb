class MacmillanDictionary
  include HTTParty
  include Nokogiri

  attr_accessor :phonetic_spelling
  attr_accessor :definition
  attr_accessor :part_of_speech
  attr_accessor :example_sentence

  API_URL = "https://www.macmillandictionary.com/api/v1/"
  URL_ENDING = "&pagesize=5&pageindex=1"

  def initialize(
    phonetic_spelling,
    definition,
    part_of_speech,
    example_sentence
  )
    @phonetic_spelling = phonetic_spelling
    @definition = definition
    @part_of_speech = part_of_speech
    @example_sentence = example_sentence
  end

  def self.define(word)
    word = word.gsub(" ", "-")
    response = HTTParty.get(
      "#{API_URL}dictionaries/american/search/?q=#{word}#{URL_ENDING}",
      headers: { "accessKey" => ENV["MACMILLAN_DICTIONARY"] }
    )

    if response.success? && response["resultNumber"] > 0
      entry_ids = []
      response["results"].each { |result| entry_ids << result["entryId"] }

      words = []
      entry_ids.each do |entry|
        response_2 = HTTParty.get(
          "#{API_URL}dictionaries/american/entries/#{entry}/?format=xml",
          headers: { "accessKey" => ENV["MACMILLAN_DICTIONARY"] }
        )

        if response_2.success?
          xml_doc = Nokogiri::XML(response_2["entryContent"])

          phonetic_spelling = xml_doc.xpath("/descendant::PRON[1]").text
          definition = xml_doc.xpath("/descendant::DEFINITION[1]").text
          part_of_speech = xml_doc.xpath("/descendant::PART-OF-SPEECH[1]").text
          example_sentence = xml_doc.xpath("/descendant::EXAMPLE[1]").text

          words << self.new(
            phonetic_spelling,
            definition,
            part_of_speech,
            example_sentence
          )
        else
          Rails.logger.error { "Error: #{response["errorMessage"]}" }
          nil
        end
      end
      words
    else
      Rails.logger.error { "Error: #{response["errorMessage"]}" }
      nil
    end
  end
end
