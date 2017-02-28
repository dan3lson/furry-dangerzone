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

	def answers
		@answers ||= []
	end

	def create_rounds
		rounds = []
		meanings = many_meaning_ques.shuffle
		syns = many_onym_ques("synonyms", "similar").shuffle
		ants = many_onym_ques("antonyms", "opposite").shuffle
		examples = many_examples_ques.shuffle
		syllables = many_syllables_ques.shuffle
		lineup = []

		20.times do |i|
			lineup.push(meanings[i], syns[i], ants[i], examples[i], syllables[i])
			jeop_round = JeopRound.new
			jeop_round.ques_num = i
			jeop_round.category = categories[i]
			jeop_round.ques = lineup[i].values.first if lineup[i]
			jeop_round.correct_ans = lineup[i].keys.first if lineup[i]
			jeop_round.linero = lineros[i]
			jeop_round.selected_ans = nil
			jeop_round.answered_correctly = nil
			rounds << jeop_round
		end

		rounds
	end

	def lineros
		%w(300 600 900 1200) * 5
	end

	def categories
		%w(meanings synonyms antonyms examples syllables) * 4
	end

	def meaning_ques(word)
		q_and_a = {}
		q_and_a[word] = askQues("means #{word.sample('definition')}")
		q_and_a
	end

	def many_meaning_ques
		words.map { |w| meaning_ques(w) }
	end

	def onym_ques(word, type, keyword)
		onyms = Thesaurus.send(type, word.name)

		unless onyms.nil? || onyms.blank?
			q_and_a = {}
			q_and_a[word] = askQues("is #{keyword} to #{onyms.first}")
			q_and_a
		end
	end

	def many_onym_ques(type, keyword)
		words.map do |w|
			onym_ques(w, type, keyword)
		end
	end

	def example_ques(word)
		if word.has_examples?
			blank_word = "_____"
			q_and_a = {}
			q_and_a[word] = askQues(
				"fills in the blank: #{word.sample('examples')}"
			).gsub(word.name, blank_word)
			q_and_a
		end
	end

	def many_examples_ques
		words.map { |w| example_ques(w) }
	end

	def syllable_ques(word)
		if word.has_syllables?
			q_and_a = {}
			q_and_a[word] = askQues(
				"has #{pluralize(word.num_syllables, 'syllable')}"
			)
			q_and_a
		end
	end

	def many_syllables_ques
		words.map { |w| syllable_ques(w) }
	end

	def askQues(tion)
		"Which word #{tion}?"
	end
end
