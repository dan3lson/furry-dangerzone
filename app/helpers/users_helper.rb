module UsersHelper
  # not tested
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

  # not tested
  def display_average_values(students, method)
    array_values = students.map { |s| s.send(method) }

    array_values.inject(&:+) / array_values.count
  end

  # not tested
  def display_average_objs(students, method)
    array_values = students.map { |s| s.send(method).count }
    binding.pry
    array_values.inject(&:+) / array_values.count
  end
end
