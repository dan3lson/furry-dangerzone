namespace :infinity do
  desc "Add 2nd Grade words to Infinity classrooms."
  task :add_words => :environment do
    teacher = Teacher.find_by(username: "kurato")
    results = []
    
    teacher.students.each do |student|
      num_words_added = student.words << Word.second_grade
      results << num_words_added == Word.second_grade.count
    end

    successfully_added = !results.include?(false)

    if successfully_added
      msg = [
        "Success! Those students now have the Grade 2 words",
        " added to their personal word-list."
      ].join
      puts msg
    else
      puts "ERROR: Something went wrong -> #{results}"
    end
  end
end
