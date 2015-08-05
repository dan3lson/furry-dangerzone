require "nokogiri"
require "open-uri"

def word_included_in_string?(word, string)
	string.include?(word.downcase) || string.include?(word.capitalize)
end

class RealWorldExample
  attr_accessor :example, :type, :source

  URL = "http://www.usatoday.com/search/"

  def initialize(example = "", type = "", source = "USA Today")
		@example = example
		@type = type
		@source = source
	end

  def self.provide(word)
		real_world_examples = []

		page = Nokogiri::HTML(open("#{URL}/#{word}/"))

		no_results = page.css("div.no-results").text

		if no_results.empty?
			page.css("h3.search-result-title").each do |title|
				rwe_mapped_examples = real_world_examples.map { |r| r.example }

				title_text = title.text

				unless title_text.split(" ").count < 5
					rwe = RealWorldExample.new
					rwe.type = "title"
					if word_included_in_string?(word, title_text)
						rwe.example = title_text
						unless rwe_mapped_examples.include?(rwe.example)
							real_world_examples << rwe
						end
					end
				end

				caption = title.next_element.text

				if word_included_in_string?(word, caption)
					rwe = RealWorldExample.new
					rwe.type = "caption"
					if caption.include?("\n")
						rwe.example = caption.split("\n").take(1).first
					else
						rwe.example = caption
					end
					unless rwe_mapped_examples.include?(rwe.example)
						real_world_examples << rwe
					end
				end
			end
			real_world_examples.take(3)
		else
			nil
    end
  end
end
