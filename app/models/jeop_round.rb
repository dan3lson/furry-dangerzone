class JeopRound
	attr_accessor :ques_num
	attr_accessor :ques_type
	attr_accessor :ques
	attr_accessor :selected_ans
	attr_accessor :correct_ans
	attr_accessor :word
	attr_accessor :linero

	def initialize(
		ques_num = nil,
		ques_type = nil,
		ques = nil,
		selected_ans = nil,
		correct_ans = nil,
		word = nil,
		linero = nil
	)
		@ques_num = ques_num
		@ques_type = ques_type
		@ques = ques
		@selected_ans = selected_ans
		@correct_ans = correct_ans
		@word = word
		@linero = linero
	end

	def has_question?
		!ques.nil?
	end
end
