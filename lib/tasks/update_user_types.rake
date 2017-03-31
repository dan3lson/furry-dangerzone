namespace :update do
  desc "Update User#role given users STI."
  task :user_roles => :environment do
    User.where(role: "admin").each do |user|
      user.update_attributes(role: "Admin")
    end

    User.where(role: "brainiac").each do |user|
      user.update_attributes(role: "Brainiac")
    end

    User.where(role: "student").each do |user|
      user.update_attributes(role: "Student")
    end

    User.where(role: "teacher").each do |user|
      user.update_attributes(role: "Teacher")
    end
  end
end
