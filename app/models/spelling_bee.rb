# TODO Create test
class SpellingBee
	attr_accessor :words

	def initialize(words)
		@words = words
	end

	def group_by_20
		words.shuffle.take(100).sort.each_slice(20).to_a.each do |group|
			group.each do |name|
				puts name
			end
			puts
		end

		# p _.flatten
	end

	def define_all
		no_good = []
		num_existing_words = 0
		num_errors = 0

		puts "Starting to define ??? Grade Words:"
		puts

		words.each do |name|
			if Word.word_exists?(name)
				puts "OK: \'#{name}\' already exists."
				num_existing_words += 1
			else
				words_api_search = WordsApi.new(name).define

				if words_api_search.class == String
					puts words_api_search
					no_good << { name: words_api_search }
					num_errors += 1
				else
					words_api_search.each do |new_word|
						if new_word.save
							puts "Success for word #{name}(#{new_word.id})"
						else
							num_errors += 1
							puts "ERROR for word #{name}: #{new_word.errors.full_messages}."
						end
					end
				end
			end
		end

		puts
		puts "Num words that already exist: #{num_existing_words}"
		puts
		puts "BAD WORDS (#{num_errors}): #{no_good}"
		puts
	end

	def retrieve_ids
		ids = []
		words.each { |name| ids << Word.where(name: name)[0].id }
		ids
		# p _
	end
end
