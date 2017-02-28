# TODO Create test
class JeopRound
	attr_accessor :ques_num
	attr_accessor :category
	attr_accessor :ques
	attr_accessor :selected_ans
	attr_accessor :correct_ans
	attr_accessor :answered_correctly
	attr_accessor :linero

	def initialize(
		ques_num = nil,
		category = nil,
		ques = nil,
		selected_ans = nil,
		correct_ans = nil,
		answered_correctly = nil,
		linero = nil
	)
		@ques_num = ques_num
		@category = category
		@ques = ques
		@selected_ans = selected_ans
		@correct_ans = correct_ans
		@answered_correctly = answered_correctly
		@linero = linero
	end

	def has_question?
		!ques.nil?
	end
end
