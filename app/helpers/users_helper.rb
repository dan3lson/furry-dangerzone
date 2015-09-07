module UsersHelper
  def display_level(user)
    if user.points == 0
      "0"
    elsif user.points >= 40 && user.points < 80
      "1"
    elsif user.points >= 80 && user.points < 120
      "2"
    elsif user.points >= 120 && user.points < 200
      "3"
    elsif user.points >= 200 && user.points < 240
      "4"
    elsif user.points >= 240 && user.points < 280
      "5"
    elsif user.points >= 280 && user.points < 360
      "6"
    elsif user.points >= 360 && user.points < 400
      "7"
    elsif user.points >= 400 && user.points < 480
      "8"
    elsif user.points >= 480 && user.points < 560
      "9"
    elsif user.points >= 560 && user.points < 640
      "10"
    elsif user.points >= 640 && user.points < 720
      "11"
    elsif user.points >= 720 && user.points < 800
      "12"
    elsif user.points >= 800 && user.points < 880
      "13"
    elsif user.points >= 880 && user.points < 960
      "14"
    elsif user.points >= 960 && user.points < 1040
      "15"
    elsif user.points >= 1040 && user.points < 1120
      "16"
    elsif user.points >= 1120 && user.points < 1200
      "17"
    elsif user.points >= 1200 && user.points < 1280
      "18"
    else
      "e"
    end
  end

  def remaining_points_to_level_up(user)
    level_system = {
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
      18 => 1200,
    }
    next_level_points = level_system[display_level(user).to_i + 1]
    next_level_points - user.points
  end
end
