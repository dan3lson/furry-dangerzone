class MacmillanDictionary
  include HTTParty
  include Nokogiri

  attr_accessor :phonetic_spelling, :definition
  attr_accessor :part_of_speech, :example_sentence

  API_URL = "https://www.macmillandictionary.com/api/v1/"

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
    response = HTTParty.get(
      "#{API_URL}dictionaries/american/search/first/?q=#{word}&format=xml",
      headers: { "accessKey" => ENV["MACMILLAN_DICTIONARY"] }
    )

    if response.success?
      xml_doc = Nokogiri::XML(response["entryContent"])

      phonetic_spelling = xml_doc.xpath("/descendant::PRON[1]").text
      definition = xml_doc.xpath("/descendant::DEFINITION[1]").text
      part_of_speech = xml_doc.xpath("/descendant::PART-OF-SPEECH[1]").text
      example_sentence = xml_doc.xpath("/descendant::EXAMPLE[1]").text

      self.new(
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
end
