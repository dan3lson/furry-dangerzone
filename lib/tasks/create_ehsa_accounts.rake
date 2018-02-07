namespace :create do
  desc "Create EHSA SMid student accounts"
  task :ehsa_accounts => :environment do
    dan3lson = User.first
    csvs = ["5N", "5VP", "7dB", "7C", "7H"]
    classrooms = []

    csvs.count.times do |index|
      classroom = Classroom.find_or_initialize_by(
        name: "#{csvs[index]} Spelling Bee (2017-2018)",
        grade: csvs[index].split("").first
      )
      classroom.teacher = dan3lson

      if classroom.save
        classrooms << classroom
        puts "Classroom \'#{classroom.name}\' saved successfully"
      else
        puts "ERROR: Classroom \'#{classroom.name}\' not saved"
      end
    end

    csvs.count.times do |index|
      CSV.foreach("./db/data/#{csvs[index]}.csv", headers: true) do |row|
        student = Student.new
        student.username = row[3].split("@").first
        student.email = row[3]
        student.password = row[0]
        student.password_confirmation = row[0]
        student.teacher = dan3lson
        student.classroom = classrooms[index]

        if student.save
          puts "Student \'#{student.username}\' saved successfully"
        else
          puts "ERROR: Student \'#{student.username}\' not saved"
        end
      end
    end
  end
end
