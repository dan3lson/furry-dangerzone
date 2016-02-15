class FreeDictionary
  include Nokogiri
  require 'open-uri'

  attr_accessor :phonetic_spelling
  attr_accessor :part_of_speech
  attr_accessor :definition
  attr_accessor :example_sentence

  URL = "http://www.thefreedictionary.com"

  def initialize(
    phonetic_spelling,
    part_of_speech,
    definition,
    example_sentence
  )
    @phonetic_spelling = phonetic_spelling
    @part_of_speech = part_of_speech
    @definition = definition
    @example_sentence = example_sentence
  end

  def self.define(word)
    word.gsub!(" ", "-")
    word.chop! if word.end_with?("-") || word.end_with?(" ")

    page = open_page(URL, word)

    definitions_exist = page.css(".ds-list").count > 0 unless page == "404"

    if definitions_exist
      words = []
      definition_divs = page.xpath(
        '//*[@id="Definition"]/section[1]'
      ).children.select do |e|
        if e.css(".ds-list").count > 0 || e.css(".ds-single").count > 0
          return nil if e.attributes["class"].nil?
          e.attributes["class"].value == "pseg"
        end
      end

      definition_divs.each do |div|
        phonetic_spellings = page.xpath(
          "//*[@id='Definition']/section[3]/h2"
        )

        if phonetic_spellings.any?
          phonetic_spelling = phonetic_spellings.first.text

          if string_has_digits?(phonetic_spelling)
            phonetic_spelling = keep_one_phonetic_spelling(phonetic_spelling)
          end
        end

        unless div.children.at_css("i").nil?
          part_of_speech = FreeDictionary.update_part_of_speech(
            div.children.at_css("i").text
          )
        end

        definition = if div.css(".ds-list").count > 0
          div.css(".ds-list").map { |div| div.text }.join("***")
        else
          div.css(".ds-single").map { |div| div.text }.join("***")
        end
        remove_ordered_list(definition)
        remove_string_in_parens(definition) if string_in_parens?(definition)

        if div.css(".illustration").count > 0
          example_sentence = div.css(".illustration").map { |div|
            next if string_in_parens?(div.text)
            div.text
          }.join("***")
        end

        strip_def_of_ex_sents(definition, example_sentence) if example_sentence

        words << self.new(
          phonetic_spelling,
          part_of_speech,
          definition,
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
    elsif string.start_with?("v") || string.start_with?("tr.v")
      "verb"
    elsif string.start_with?("adv")
      "adverb"
    else
      nil
    end
  end

  def self.remove_ordered_list(string)
    string.gsub!(/\d+./, "")
  end

  def self.keep_one_phonetic_spelling(string)
    string.gsub(/\d/, ";").split(";").first
  end

  def self.string_has_digits?(string)
    string =~ /\d/ ? true : false
  end

  def self.string_in_parens?(string)
    (string.start_with?("(") && string.end_with?(").")) ||
    string.end_with?(").")
  end

  def self.remove_string_in_parens(string)
    string.gsub!(" #{string.slice(string.index("("), string.length)}", "")
  end

  def self.strip_def_of_ex_sents(definitions, example_sentences)
    example_sentences = example_sentences.split("***")

    example_sentences.each do |es|
      if definitions.include?(es)
        definitions.gsub!(": #{es}", " ")
      end
    end

    definitions
  end

  private

  def self.open_page(url, word)
    begin
      Nokogiri::HTML(open("#{url}/#{word}"))
    rescue OpenURI::HTTPError
      "404"
    end
  end
end
