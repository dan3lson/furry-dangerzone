class FreeDictionary
  include HTTParty
  include Nokogiri

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

    page = Nokogiri::HTML(open("#{URL}/#{word}"))

    definitions_exist = page.css(".ds-list").count > 0

    if page && definitions_exist
      words = []

      good_divs = page.xpath(
        '//*[@id="Definition"]/section[2]'
      ).children.select { |elem|
        elem.attributes.count == 0 && elem.name == "div"
      }

      good_divs.each do |div|
        phonetic_spellings = page.css("h2").select { |e| e.text.include?("•") }

        if phonetic_spellings.any?
          phonetic_spelling = phonetic_spellings.first.text
        end

        definition = div.css(".ds-list").map { |div| div.text }.join("***")

        unless div.children.at_css("i").nil?
          part_of_speech = FreeDictionary.update_pos(
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

      words
    else
      nil
    end
  end

  def self.update_pos(string)
    if string.start_with?("n")
      "noun"
    elsif string.start_with?("adj")
      "adjective"
    elsif string.start_with?("v")
      "verb"
    end
  end
end
