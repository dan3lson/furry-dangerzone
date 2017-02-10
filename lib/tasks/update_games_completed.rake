namespace :update do
  desc "Update UserWord#games_completed given new gamezone structure."
  task :games_completed => :environment do
    UserWord.all.each do |uw|
      if uw.games_completed == 0
        puts uw.update_attributes(games_completed: 0)
      elsif uw.games_completed == 1
        puts uw.update_attributes(games_completed: 6)
      elsif uw.games_completed == 2
        if uw.word.has_sent_stems?
          puts uw.update_attributes(games_completed: 8)
        else
          puts uw.update_attributes(games_completed: 9)
        end
      elsif uw.games_completed == 3
        puts uw.update_attributes(games_completed: 12)
      end
    end
  end
end
