# TODO Create tests
class JeopGame
	include ActionView::Helpers::TextHelper

	def initialize(words)
		@words = words
	end

	def rounds
		create_rounds
	end

	def self.rows(array, num)
		array.each_slice(num).to_a
	end

	private

	attr_reader :words

	def create_rounds
		rounds = []
		wordz = words * 5
		meanings = many_meaning_ques
		synonyms = many_onym_ques("synonyms", "similar")
		antonyms = many_onym_ques("antonyms", "opposite")
		examples = many_examples_ques
		syllables = many_syllables_ques
		question_order = []

		20.times do |i|
			question_order.push(
				meanings[i],
				synonyms[i],
				antonyms[i],
				examples[i],
				syllables[i]
			)
			jeop_round = JeopRound.new
			jeop_round.ques_num = i
			jeop_round.ques_type = ques_types[i]
			jeop_round.ques = question_order[i]
			jeop_round.selected_ans = nil
			jeop_round.correct_ans = wordz[i].name
			jeop_round.word = wordz[i]
			jeop_round.linero = lineros[i]
			rounds << jeop_round
		end

		rounds
	end

	def lineros
		%w(300 600 900 1200) * 5
	end

	def ques_types
		%w(meanings synonyms antonyms examples syllables) * 5
	end

	def meaning_ques(word)
		askQues("means #{word.definition}")
	end

	def many_meaning_ques
		words.map { |w| meaning_ques(w) }.shuffle
	end

	def onym_ques(name, type, keyword)
		onyms = Thesaurus.send(type, name)

		unless onyms.nil? || onyms.blank?
			onyms.map { |w| askQues("is #{keyword} to #{w}") }
		end
	end

	def many_onym_ques(type, keyword)
		words.map { |w| onym_ques(w.name, type, keyword) }.flatten.compact.shuffle
	end

	def example_ques(word)
		askQues("fills in the blank: ...TBD for #{word.name}...")
	end

	def many_examples_ques
		words.map { |w| example_ques(w) }.shuffle
	end

	def syllable_ques(word)
		if word.has_syllables?
			askQues("has #{pluralize(word.num_syllables, 'syllable')}")
		end
	end

	def many_syllables_ques
		words.map { |w| syllable_ques(w) }.shuffle
	end

	def askQues(tion)
		"Which word #{tion}?"
	end
end
