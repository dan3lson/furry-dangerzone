class FreeDictionary
  include HTTParty
  include Nokogiri
  # require 'open-uri'

  attr_accessor :phonetic_spelling
  attr_accessor :definition
  attr_accessor :part_of_speech
  attr_accessor :example_sentence

  URL = "http://www.thefreedictionary.com"

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
    word.gsub!(" ", "-")
    word.chop! if word.end_with?("-") || word.end_with?(" ")

    page = open_page(URL, word)

    definitions_exist = page.css(".ds-list").count > 0 unless page == "404"

    if definitions_exist
      words = []

      good_divs = page.xpath(
        '//*[@id="Definition"]/section[2]'
      ).children.select { |e| e.attributes.count == 0 && e.name == "div" }

      good_divs.each do |div|
        phonetic_spellings = page.css("h2").select { |e| e.text.include?("•") }

        if phonetic_spellings.any?
          phonetic_spelling = phonetic_spellings.first.text
        end

        definition = div.css(".ds-list").map { |div| div.text }.join("***")

        unless div.children.at_css("i").nil?
          part_of_speech = FreeDictionary.update_part_of_speech(
            div.children.at_css("i").text
          )
        end

        example_sentence = div.css(".illustration").map { |div|
          div.text
        }.join("***") if div.css(".illustration").count > 0

        words << self.new(
          phonetic_spelling,
          definition,
          part_of_speech,
          example_sentence
        )
      end

      words if words.any?
    else
      nil
    end
  end

  def self.update_part_of_speech(string)
    if string.start_with?("n")
      "noun"
    elsif string.start_with?("adj")
      "adjective"
    elsif string.start_with?("v")
      "verb"
    elsif string.start_with?("adv")
      "adverb"
    else
      nil
    end
  end

  private

  def self.open_page(url, word)
    begin
      Nokogiri::HTML(open("#{url}/#{word}"))
    rescue OpenURI::HTTPError => error
      "404"
    end
  end
end
