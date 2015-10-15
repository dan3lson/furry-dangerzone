class GameStat < ActiveRecord::Base
  belongs_to :user_word
  belongs_to :game

  validates :user_word, presence: true
  validates :game, presence: true
  validates :num_played, presence: true

  def self.update_fundamental_stats
    fund_game = Game.find_by(name: "Fundamentals")

    UserWord.all.each do |uw|
      if uw.fundamental_completed?
        game_stat = GameStat.where(user_word: uw, game: fund_game).first_or_initialize
        game_stat.num_played += 1

        if game_stat.save
          puts "#{uw.id} num_played updated successfully."
        else
          puts "ERROR: #{uw.id} num_played NOT updated successfully."
        end
      else
        puts "#{uw.id}\'s Fundamental game not completed. No updated needed."
      end
    end
  end
end
