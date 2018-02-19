class School::ActivitiesController < BaseSchoolController
  def index
    @user_activities = current_user.students
                                   .map { |s| s.activities }
                                   .delete_if { |a| a.empty? }
                                   .flatten
    @any_activities_exist = !@user_activities.empty?
    @user_activities = @user_activities.group_by { |a|
      a.user.username
    } if @any_activities_exist
  end
end
