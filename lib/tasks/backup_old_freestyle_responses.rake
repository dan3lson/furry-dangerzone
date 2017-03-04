namespace :old_freestyle_responses do
  desc "Back up all the old Freestyle Responses into a csv"
  task :backup => :environment do
    CSV.open("./db/data/old_freestyle_responses_backup.csv", "w") do |row|
      FreestyleResponse.where.not(focus: nil).all.each do |f_r|
        user_word = f_r.user_word
        game_stat = GameStat.find_by(user_word: user_word)
        row << [
          user_word.user.id,
          user_word.user.username,
          user_word.word.id,
          user_word.word.name,
          f_r.focus,
          game_stat.id,
          game_stat.num_played,
          game_stat.time_spent
        ]
      end
    end
  end
end
