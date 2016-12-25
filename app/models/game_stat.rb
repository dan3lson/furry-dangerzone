class GameStat < ActiveRecord::Base
  belongs_to :user_word
  belongs_to :game

  validates :user_word, presence: true
  validates :game, presence: true
  validates :num_played, presence: true
  validates :num_jeop_won, presence: true
  validates :num_jeop_lost, presence: true

  # TODO: Create test 
  def self.update_user_word_game_stats(user, word, game, time_spent)
    user_word = UserWord.find_by(user: user, word: word)
    gs = GameStat.where(game: game, user_word: user_word).first_or_initialize
    time_spent = time_spent.to_f.round(2)
    gs.num_played += 1
    gs.time_spent += time_spent

    if gs.save
      msg = "Success: GameStat #{gs.id} num_played and time_spent "

      "#{msg} updated for UW #{user_word.id} -> #{user_word.word.name}."
    else
      msg = "ERROR: GameStat #{gs.id} num_played OR time_spent not "
      msg_2 = "successfully updated for UW #{user_word.id} -> "

      "#{msg} #{msg_2} #{user_word.word.name}."
    end
  end
end
