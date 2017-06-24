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

	def retrieve_ids
		ids = []
		words.each { |name| ids << Word.where(name: name)[0].id }
		ids
		# p _
	end
end
