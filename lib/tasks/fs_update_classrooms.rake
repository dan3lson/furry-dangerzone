namespace :fs do
  desc "Update legacy teacher/classroom, i.e. Friends Seminary, data"
  task :update_classrooms => :environment do
    usernames = %w(
      22annenberg
      22bloch
      22chawla
      22kellner
      22musso
      22nino
      22parr
      22pass
      22riordan
      22seldman
      22spencer
      22sriram
      22tarta
      22vail
      22watts
      22yamazaki
      22zenkerc
    )
    fs_class_one = where(username: usernames)
    usernames_two = %w(
      22ball
      22bugdaycay
      22caiola
      22earle
      22friedman
      22gott
      22gund-morrow
      22halverstadt
      22juneja
      22luard
      22palladino
      22pratofiorito
      22ragins
      22tartj
      22weber
      22zenkerm
    )
    fs_class_two = where(username: usernames)
  end
end
