module UsersHelper
  def current_level(user)
    if user.points == 0
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
      "e"
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

  def percent_complete(user)
    ((diff_btwn_curr_and_next_lvl(user) - pts_to_level_up(user)).to_f /
      diff_btwn_curr_and_next_lvl(user).to_f) * 100
  end

  def progress_snapshot_motivation(user)
    if percent_complete(user) >= 0.0 && percent_complete(user) < 25.0
      "Hey #{user.username}, get going on achieving Level #{next_level(user)}!"
    elsif percent_complete(user) >= 25.0 && percent_complete(user) < 50.0
      "Nice job getting started. Keep playing!"
    elsif percent_complete(user) >= 50.0 && percent_complete(user) < 75.0
      "Great job, you\'re more than halfway to Level #{next_level(user)}!"
    elsif percent_complete(user) >= 75.0 && percent_complete(user) <= 100.0
      "You\'re so close; Level #{next_level(user)} is in sight!"
    else
      "Yikes! Motivations will be right back..."
    end
  end
end
