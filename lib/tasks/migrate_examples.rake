namespace :examples do
  desc "Move word.example to word.examples via new examples table"
  task :migrate => :environment do
    words_with_examples = Word.where.not(example_sentence: nil)
    num_errors = 0

    words_with_examples.each do |word|
      examples = word.example_sentence.split("***").reject(&:empty?).join("***")
      data = { word_id: word.id, text: examples }
      new_example = Example.new(data)

      if new_example.save
        puts "Success: Example created for Word #{word.id}."
      else
        puts
        puts "ERROR: Example not created for Word #{word.id}."
        puts new_example.errors.full_messages
        puts
        num_errors += 1
      end
    end
    puts
    puts "TOTAL ERRORS: #{num_errors}"
  end
end
