module FreestyleResponsesHelper
	# not tested
	def semantic_responses(user_word)
		FreestyleResponse.sorted_for(user_word)[0..2]
	end

	# not tested
	def word_map_responses(user_word)
		FreestyleResponse.sorted_for(user_word)[3..5]
	end

	# not tested
	def definition_map_responses(user_word)
		FreestyleResponse.sorted_for(user_word)[6..8]
	end

	# not tested
	def sentence_responses(user_word)
		FreestyleResponse.sorted_for(user_word)[9..11]
	end
end
