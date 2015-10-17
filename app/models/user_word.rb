class UserWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  has_many :user_word_game_levels, dependent: :destroy
  has_many :game_levels, through: :user_word_game_levels
  has_many :game_stats, dependent: :destroy

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

  def retrieve_uwgls_for(game_name)
    UserWordGameLevel.includes(:user_word).includes(:game_level).select { |uwgl|
      uwgl.user_word == self && uwgl.game_level.game.name == game_name
    }
  end

  def uwgl_fundamentals
    retrieve_uwgls_for("Fundamentals")
  end

  def uwgl_jeopardys
    retrieve_uwgls_for("Jeopardy")
  end

  def uwgl_freestyles
    retrieve_uwgls_for("Freestyle")
  end

  def fundamental_statuses
    num_not_started = 0
    num_in_progress = 0
    num_complete = 0

    uwgl_fundamentals.each do |uwgl|
      if uwgl.status == "not started"
        num_not_started += 1
      elsif uwgl.status == "in progress"
        num_in_progress += 1
      elsif uwgl.status == "complete"
        num_complete += 1
      end
    end

    [num_not_started, num_in_progress, num_complete]
  end

  def fundamental_not_started?
    num = 0

    uwgl_fundamentals.each { |uwgl| num += 1 if uwgl.status == "not started" }

    num == 8
  end

  def fundamental_in_progress?
    uwgl_fundamentals.map { |uwgl| uwgl.status }.uniq.count == 2
  end


  def fundamental_completed?
    num = 0

    uwgl_fundamentals.each { |uwgl| num += 1 if uwgl.status == "complete" }

    num == 8
  end

  def jeopardy_not_started?
    num = 0

    uwgl_jeopardys.each { |uwgl| num += 1 if uwgl.status == "not started" }

    num == 20
  end

  def jeopardy_completed?
    num = 0

    uwgl_jeopardys.each { |uwgl| num += 1 if uwgl.status == "complete" }

    num == 20
  end

  def freestyle_not_started?
    num = 0

    uwgl_freestyles.each { |uwgl| num += 1 if uwgl.status == "not started" }

    num == 12
  end

  def freestyle_completed?
    num = 0

    uwgl_freestyles.each { |uwgl| num += 1 if uwgl.status == "complete" }

    num == 12
  end

  def self.destroy_jeopardys_for(user_word)
    user_word.uwgl_jeopardys.each { |uwgl| uwgl.destroy }
  end

  def self.fix_rogue_uwgls
    select { |uw| uw.user_word_game_levels.count > 40 }.map { |uw|
      uw.user_word_game_levels.count
    }

    uw.uwgl_freestyles.each do |uwgl|
      puts "Game: #{uwgl.game_level.game.name}"
      puts "Status: #{uwgl.status}"
      puts "Created at #{uwgl.created_at}"
      puts "Updated at #{uwgl.updated_at}"
      puts "**********************************"
    end
  end
end
