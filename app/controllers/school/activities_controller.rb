class School::ActivitiesController < BaseSchoolController
  def index
   @student_ids = current_user.students.pluck(:id)
   @activities = Activity.includes(:user)
                         .where(users: { id: @student_ids})
                         .group_by { |a| a.user.username }
  end
end
