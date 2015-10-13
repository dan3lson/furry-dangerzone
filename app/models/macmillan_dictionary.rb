class MacmillanDictionary
  include HTTParty
  include Nokogiri

  attr_accessor :phonetic_spelling
  attr_accessor :definition
  attr_accessor :part_of_speech
  attr_accessor :example_sentence

  API_URL = "https://www.macmillandictionary.com/api/v1/"
  URL_ENDING = "&pagesize=3&pageindex=1"

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
    word.gsub!(" ", "-") if word.split.count > 1

    response = HTTParty.get(
      "#{API_URL}dictionaries/american/search/?q=#{word}#{URL_ENDING}",
      headers: { "accessKey" => ENV["MACMILLAN_DICTIONARY"] }
    )

    if response.success? && response["resultNumber"] > 0
      entry_ids = []
      words = []

      response["results"].each do |result|
        entry = result["entryId"]
        next if entry_ids.include?(entry)
        entry_ids << entry
      end

      entry_ids.each do |entry|
        response_2 = HTTParty.get(
          "#{API_URL}dictionaries/american/entries/#{entry}/?format=xml",
          headers: { "accessKey" => ENV["MACMILLAN_DICTIONARY"] }
        )

        if response_2.success?
          xml_doc = Nokogiri::XML(response_2["entryContent"])
          phonetic_spelling = xml_doc.xpath("/descendant::PRON[1]").text
          definitions = xml_doc.xpath("/descendant::DEFINITION")
          part_of_speech = xml_doc.xpath("/descendant::PART-OF-SPEECH[1]").text
          example_sentences = xml_doc.xpath("/descendant::EXAMPLE")

          if definitions.count == 0
            nil
          else
            phonetic_spelling[0] = "" if phonetic_spelling[0] == " "

            if part_of_speech[0] == " "
              part_of_speech[0] = "" unless part_of_speech[0] == "p"
            end

            definitions = definitions.map { |d| d.text }

            definitions.each { |d| d[0] = "" }

            definition = definitions.join(";")

            example_sentences = example_sentences.map { |d| d.text }

            example_sentences.each { |es| es[0] = "" if es[0] == " " }

            example_sentence = example_sentences.join(";")

            words << self.new(
              phonetic_spelling,
              definition,
              part_of_speech,
              example_sentence
            )
          end
        else
          nil
        end
      end
      words
    else
      nil
    end
  end
end
