module UsersHelper
  def weekly_goal(user)
    if user.goal == 1
      "Basic"
    elsif user.goal == 5
      "Casual"
    elsif user.goal == 10
      "Regular"
    elsif user.goal == 20
      "Serious"
    elsif user.goal == 30
      "Insane"
    else
      "No goal set"
    end
  end

  def words_mastered_in_a_week(user)
    beginning_of_week = Date.today.beginning_of_week
    end_of_week = Date.today.end_of_week
    week = beginning_of_week..end_of_week

    user.completed_freestyles.select do |uw|
      week.include?(uw.updated_at.to_date)
    end
  end

  def num_words_mastered_in_a_week(user)
    words_mastered_in_a_week(user).count
  end

  def weekly_goal_completed?(user)
    num_words_mastered_in_a_week(user) >= user.goal
  end

  def goal_percentage_completion(user)
    num_words_mastered_in_a_week = num_words_mastered_in_a_week(user)

    if num_words_mastered_in_a_week == 0
      0
    elsif weekly_goal_completed?(user)
      100
    else
      (num_words_mastered_in_a_week / user.goal.to_f * 100).round
    end
  end

  def calculate_streak(user)
    streak = 0
    num_freestyles_completed = user.completed_freestyles.count
    today = Date.today
    yesterday = Date.yesterday

    date = user.completed_freestyle_on?(today) ? today : yesterday

    num_freestyles_completed.times do
      user_has_completed_freestyle_on_date = user.completed_freestyle_on?(date)

      if user_has_completed_freestyle_on_date
        streak += 1
        date -= 1
      else
        streak > 0 ? streak : 0
      end
    end

    streak
  end

  # Need to reevaluate system and test

  def current_level(user)
    if user.points >= 0 && user.points < 40
      0
    elsif user.points >= 40 && user.points < 80
      1
    elsif user.points >= 80 && user.points < 120
      2
    elsif user.points >= 120 && user.points < 200
      3
    elsif user.points >= 200 && user.points < 240
      4
    elsif user.points >= 240 && user.points < 280
      5
    elsif user.points >= 280 && user.points < 360
      6
    elsif user.points >= 360 && user.points < 400
      7
    elsif user.points >= 400 && user.points < 480
      8
    elsif user.points >= 480 && user.points < 560
      9
    elsif user.points >= 560 && user.points < 640
      10
    elsif user.points >= 640 && user.points < 720
      11
    elsif user.points >= 720 && user.points < 800
      12
    elsif user.points >= 800 && user.points < 880
      13
    elsif user.points >= 880 && user.points < 960
      14
    elsif user.points >= 960 && user.points < 1040
      15
    elsif user.points >= 1040 && user.points < 1120
      16
    elsif user.points >= 1120 && user.points < 1200
      17
    elsif user.points >= 1200 && user.points < 1280
      18
    else
      33333
    end
  end

  def level_system
    {
      0 => 0,
      1 => 40,
      2 => 80,
      3 => 120,
      4 => 200,
      5 => 240,
      6 => 280,
      7 => 360,
      8 => 400,
      9 => 480,
      10 => 560,
      11 => 640,
      12 => 720,
      13 => 800,
      14 => 880,
      15 => 960,
      16 => 1040,
      17 => 1120,
      18 => 1200
    }
  end

  def next_level(user)
    current_level(user) + 1
  end

  def next_level_in_points(user)
    level_system[current_level(user) + 1]
  end

  def pts_to_level_up(user)
    next_level_in_points(user) - user.points
  end

  def diff_btwn_curr_and_next_lvl(user)
    next_level_in_points(user) - level_system[current_level(user)]
  end

  def motivate(user)
    if goal_percentage_completion(user) >= 0 &&
       goal_percentage_completion(user) < 25
      msg = "Hey #{user.username.capitalize}, get going on achieving your goal"
      "#{msg} by mastering one word at a time."
    elsif goal_percentage_completion(user) >= 25 &&
          goal_percentage_completion(user) < 50
      "#{user.username.capitalize}, nice job getting started. Keep playing!"
    elsif goal_percentage_completion(user) >= 50 &&
          goal_percentage_completion(user) < 75
      msg = "Great job, #{user.username.capitalize} - you\'re more than"
      "#{msg} halfway to your goal!"
    elsif goal_percentage_completion(user) >= 75 &&
          goal_percentage_completion(user) <= 99
      msg = "You\'re so close, #{user.username.capitalize}!"
      "#{msg}"
    elsif goal_percentage_completion(user) == 100
      msg = "Awesome job completing this week\'s goal of "
      "#{msg} #{pluralize(current_user.goal, "word")}!!"
    else
      "Yikes! Motivations will be right back..."
    end
  end
end
