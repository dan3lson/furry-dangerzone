namespace :define do
  desc "Define 2nd grade words from list"
  task :second_grade_words => :environment do
    puts "Starting to define 2nd Grade Words:"
    puts
    rand_word_names = Word.second_grade_word_names.shuffle.take(75).sort
    num_errors = 0
    new_word_ids = []

    rand_word_names.each do |name|
      words_api_search = WordsApi.new(name).define

      if words_api_search.class == String
        puts words_api_search
      else
        words_api_search.each_with_index do |new_word, index|
          if new_word.save
            new_word_ids << new_word.id if index == 0
            puts "Success for word #{name}(#{new_word.id})"
          else
            num_errors += 1
            puts "ERROR for word #{name}: #{new_word.errors.full_messages}."
          end
        end
      end
    end

    puts
    print new_word_ids
    puts
    puts
    print rand_word_names
    puts
    puts
    puts "TOTAL ERRORS: #{num_errors}"
  end
end
