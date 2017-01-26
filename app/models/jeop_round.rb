class JeopRound
	attr_accessor :ques_num
	attr_accessor :ques_type
	attr_accessor :ques
	attr_accessor :selected_ans
	attr_accessor :correct_ans
	attr_accessor :word_id
	attr_accessor :linero

	def initialize(
		ques_num = nil,
		ques_type = nil,
		selected_ans = nil,
		correct_ans = nil,
		word_id = nil,
		linero = nil
	)
		@ques_num = ques_num
		@ques_type = ques_type
		@selected_ans = selected_ans
		@correct_ans = correct_ans
		@word_id = word_id
		@linero = linero
	end
end
