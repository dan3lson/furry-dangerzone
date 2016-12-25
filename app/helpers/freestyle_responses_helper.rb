module FreestyleResponsesHelper
	# TODO: Create test 
	def semantic_responses(user_word)
		FreestyleResponse.sorted_for(user_word)[0..2]
	end

	# TODO: Create test 
	def word_map_responses(user_word)
		FreestyleResponse.sorted_for(user_word)[3..5]
	end

	# TODO: Create test 
	def definition_map_responses(user_word)
		FreestyleResponse.sorted_for(user_word)[6..8]
	end

	# TODO: Create test 
	def sentence_responses(user_word)
		FreestyleResponse.sorted_for(user_word)[9..11]
	end
end
