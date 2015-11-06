class UserWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word

  has_many :freestyle_responses, dependent: :destroy
  has_many :user_word_game_levels, dependent: :destroy
  has_many :game_levels, through: :user_word_game_levels
  has_many :game_stats, dependent: :destroy

  validates :games_completed, presence: true
  validates :user, presence: true
  validates :word, presence: true

  def current_game
    game_ids = game_levels.pluck(:game_id).uniq

    if freestyle_completed?
      "all-games-completed"
    elsif game_ids.count == 1
      "one"
    elsif game_ids.count == 2
      "two"
    elsif game_ids.count == 3
      "three"
    else
      nil
    end
  end

  # def current_game
  #   if games_completed == 0
  #     "one"
  #   elsif games_completed == 1
  #     "two"
  #   elsif games_completed == 2
  #     "three"
  #   elsif games_completed == 3
  #     "all-games-completed"
  #   else
  #     nil
  #   end
  # end

  def fundamental_completed?
    games_completed > 0
  end

  def fundamental_not_completed?
    current_game == "one" && !fundamental_completed?
  end

  def jeopardy_completed?
    games_completed == 2 || games_completed == 3
  end

  def jeopardy_not_completed?
    current_game == "two" && !jeopardy_completed?
  end

  def uwgls
    UserWordGameLevel.where(user_word: self).order(:game_level_id)
  end

  def uwgl_freestyles
    uwgls.drop(28)
  end

  def freestyle_completed?
    num = 0

    uwgl_freestyles.each { |uwgl| num += 1 if uwgl.status == "complete" }

    num == 12
  end

  # def freestyle_completed?
  #   jeopardy_completed? && games_completed == 3
  # end

  def freestyle_not_completed?
    current_game == "three" && !freestyle_completed?
  end

  # def fundamental_completed_last_day?
  #   first_uwgl_fundamental = self.uwgl_fundamentals.first
  #
  #   first_uwgl_fundamental.updated_at >= 1.days.ago &&
  #   (first_uwgl_fundamental.created_at != first_uwgl_fundamental.updated_at)
  # end
  #
  # def jeopardy_completed_last_day?
  #   first_uwgl_jeopardy = self.uwgl_jeopardys.first
  #
  #   first_uwgl_jeopardy.updated_at >= 1.days.ago &&
  #   (first_uwgl_jeopardy.created_at != first_uwgl_jeopardy.updated_at)
  # end
  #
  # def freestyle_completed_last_day?
  #   first_uwgl_freestyle = self.uwgl_freestyles.first
  #
  #   first_uwgl_freestyle.updated_at >= 1.days.ago &&
  #   (first_uwgl_freestyle.created_at != first_uwgl_freestyle.updated_at)
  # end

  def self.simplify_backend
    good_uws = []
    bad_uws = []

    all.each do |uw|
      if uw.current_game == "one"
      	uw.games_completed = 0

        if uw.save
          good_uws << "Success updating g_com: UW #{uw.id} -> #{uw.word.name} -> #{uw.games_completed}"
        else
          bad_uws << "ERROR in saving games_completed for UW #{uw.id}."
        end
      elsif uw.current_game == "two"
      	uw.games_completed = 1

        if uw.save
          good_uws << "Success updating g_com: UW #{uw.id} -> #{uw.word.name} -> #{uw.games_completed}"
        else
          bad_uws << "ERROR in saving games_completed for UW #{uw.id}."
        end
      elsif uw.current_game == "three"
      	uw.games_completed = 2

        if uw.save
          good_uws << "Success updating g_com: UW #{uw.id} -> #{uw.word.name} -> #{uw.games_completed}"
        else
          bad_uws << "ERROR in saving games_completed for UW #{uw.id}."
        end
      elsif uw.current_game == "all-games-completed"
      	uw.games_completed = 3

        if uw.save
          good_uws << "Success updating g_com: UW #{uw.id} -> #{uw.word.name} -> #{uw.games_completed}"
        else
          bad_uws << "ERROR in saving games_completed for UW #{uw.id}."
        end
      elsif uw.current_game.nil?
      	uw.games_completed = 0

        if uw.save
          good_uws << "Success updating NIL g_com: UW #{uw.id} -> #{uw.word.name} -> #{uw.games_completed}"
        else
          bad_uws << "ERROR in saving games_completed for UW #{uw.id}."
        end
      else
      	bad_uws << "ERROR in updating games_completed for UW #{uw.id}."
      end
    end

    [good_uws, bad_uws]
  end
end
