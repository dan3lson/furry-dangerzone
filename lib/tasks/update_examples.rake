namespace :update do
  desc "Update all words with examples from Words API."
  task :examples => :environment do
    names = Word.all.limit(10).group_by(&:name)

    names.each do |name, array|
      next if name.include?("-") || name.split(" ").count > 1
      new_examples = WordsApi.new(name).examples
      next if new_examples.nil? || new_examples.empty?
      words = Word.where(name: name)

      words.map do |w|
        if w.examples.empty?
          example = Example.new(text: new_examples, word: w)
          w.examples << example
          puts w.examples.count > 0 ? "Success: #{name}" : "ERROR: #{name}"
        else
          example = Example.find_by(word: w)
          text = example.text
          new_text = text << "***#{new_examples}"
          saved = example.update_attributes(text: new_text)
          puts saved ? "Success: #{name}" : "ERROR: #{name}"
        end
      end
    end
  end
end
