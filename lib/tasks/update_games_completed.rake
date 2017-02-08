namespace :games_completed do
  desc "Update UserWord#games_completed given new gamezone structure."
  task :update => :environment do
    UserWord.all.each do |uw|
      next if uw.games_completed == 0

      if uw.games_completed == 1
        uw.update_attributes(games_completed: 6)
      elsif uw.games_completed == 2
        uw.update_attributes(games_completed: 8)
      elsif uw.games_completed == 3
        uw.update_attributes(games_completed: 12)
      end
    end
  end
end
