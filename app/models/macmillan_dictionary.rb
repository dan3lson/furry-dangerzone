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

          if definition.empty?
            # Rails.logger.info { "INFO: #{entry} has no definition!" }
            nil
          else
            phonetic_spelling[0] = "" if phonetic_spelling[0] == " "

            if part_of_speech[0] == " "
              part_of_speech[0] = "" unless part_of_speech[0] == "p"
            end

            definition[0] = ""

            example_sentence[0] == "" if example_sentence[0] == " "

            words << self.new(
              phonetic_spelling,
              definition,
              part_of_speech,
              example_sentence
            )
          end
        else
          # Rails.logger.error { "ERROR!: ADDING #{entry} didn\'t work!" }
          nil
        end
      end
      words
    else
      # Rails.logger.error { "ERROR: #{response["errorMessage"]}" }
      nil
    end
  end
end

# ERROR IS BEING RETURNED BECAUSE THE ENTRY IS NOT FOUND AND NIL IS RETURNED
# BUT ERROR IS LOGGED --> STILL NOT SURE WHY JUST "ERROR" IS SHOWN
