class Thesaurus
  include HTTParty
  include Nokogiri

  attr_accessor :response

  API_URL = "http://words.bighugelabs.com/api/2"
  API_KEY = ENV["BIG_HUGE_THESAURUS"]

  def initialize
    @response
  end

  def self.provide(word, syn_or_ant, part_of_speech)
    connection = HTTParty.get("#{API_URL}/#{API_KEY}/#{word}/json")

    if connection.success?
      part_of_speech.gsub!(" ", "")

      response = JSON.parse(connection)

      response = if response[part_of_speech][syn_or_ant].nil?
                   nil
                 else
                   response[part_of_speech][syn_or_ant].take(3)
                 end
    else
      # Rails.logger.error { "Error: something didn\'t work..." }
      nil
    end
  end

  def self.insert_words_for(word, syn_or_ant, pos)
    @thesaurus = Thesaurus.provide(word.name, syn_or_ant, pos)

    unless @thesaurus.nil?
      @thesaurus.each do |w|
        next if MacmillanDictionary.define(w).nil?

        palabra = Word.define(w).first

        unless palabra.blank?
          if syn_or_ant == "syn"
            if !word.synonyms.pluck(:id).include?(palabra.id)
              word.synonyms << palabra
            end
          else
            if !word.antonyms.pluck(:id).include?(palabra.id)
              word.antonyms << palabra
            end
          end
        end
      end
    end
  end
end
