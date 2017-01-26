class Round
	attr_accessor :ques_num
	attr_accessor :selected_ans
	attr_accessor :correct_ans
	attr_accessor :word_id

	def initialize(
		ques_num = nil,
		selected_ans = nil,
		correct_ans = nil,
		word_id = nil
	)
		@ques_num = ques_num
		@selected_ans = selected_ans
		@correct_ans = correct_ans
		@word_id = word_id
	end
end
