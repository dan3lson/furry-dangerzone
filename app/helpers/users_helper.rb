module UsersHelper
  # TODO: Create test
  def display_average_values(students, method)
    array_values = students.map { |s| s.send(method) }
    array_values.inject(&:+) / array_values.count
  end

  # TODO: Create test
  def display_average_objs(students, method)
    array_values = students.map { |s| s.send(method).count }
    array_values.inject(&:+) / array_values.count
  end

  # TODO: Create test
  def display_greeting(user)
    emoji("bust_in_silhouette") + " Hello, #{user.username}!"
  end
end
