namespace :reset do
  desc "Reset user passwords in the dev environment."
  task :dev_pwds => :environment do
    if Rails.env == "development"
      dan3lson = User.first

      User.all.each do |user|
        user.password = "password"
        user.password_confirmation = "password"

        if user.is_student? && !user.is_teacher?
          unless user.belongs_to_classroom?
            user.teacher = dan3lson
            user.classroom = Classroom.find_or_create_by(
              name: "Unassigned",
              grade: 1
            )
          end
        end

        if user.save!
          puts "User #{user.username} password updated successfully"
        else
          puts "ERROR: User #{user.username} password not updated successfully"
        end
      end
    end
  end
end
