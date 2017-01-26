class JeopGame
	def initialize(words)
		@words = words
	end

	def rounds
		create_rounds
	end

	private

	attr_reader :words

	def create_rounds
		rounds = []

		words.each_with_index do |w, i|
			jeop_round = JeopRound.new
			jeop_round.ques_num = i
			jeop_round.ques_type = ques_types[i]
			jeop_round.ques = questions[i]
			jeop_round.selected_ans = nil
			jeop_round.correct_ans = w.name
			jeop_round.word_id = w.id
			jeop_round.linero = lineros[i]
			rounds << jeop_round
		end

		rounds
	end

	def lineros
		%w(200 400 600 800 1000) * 5
	end

	def ques_types
		%w(meaning synonym antonym example syllable) * 5
	end

	def questions
		(%w(hey hola hi yo wazzup sup) * 4).map { |w| "What is #{w}?" }
	end
end
