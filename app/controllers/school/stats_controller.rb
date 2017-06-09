class School::StatsController < BaseSchoolController
  # def progress
  #   @class = params[:filter] ? User.send(params[:filter]) : User.fs_class_one
  #   @title_and_header = if params[:filter]
  #     params[:filter] == "fs_class_one" ? "Class One" : "Class Two"
  #   else
  #     "Class One"
  #   end
  #
  #   @sorted_myLeksi_mastery = @class.sort_by(&:myLeksi_mastery)
  #   @lowest_myLeksi_mastery = @sorted_myLeksi_mastery.take(5)
  #   @highest_myLeksi_mastery = @sorted_myLeksi_mastery.reverse.take(5)
  #
  #   @sorted_words_count = @class.sort_by { |u| u.num_words }
  #   @least_saved_words = @sorted_words_count.take(5)
  #   @most_saved_words = @sorted_words_count.reverse.take(5)
  #
  #   @sorted_completed_fundamentals = @class.sort_by { |u|
  #     u.completed_fundamentals.count
  #   }
  #   @least_funds_played = @sorted_completed_fundamentals.take(5)
  #   @most_funds_played = @sorted_completed_fundamentals.reverse.take(5)
  #
  #   @sorted_completed_jeopardys = @class.sort_by { |u|
  #     u.completed_jeopardys.count
  #   }
  #   @least_jeops_played = @sorted_completed_jeopardys.take(5)
  #   @most_jeops_played = @sorted_completed_jeopardys.reverse.take(5)
  #
  #   @sorted_completed_freestyles = @class.sort_by { |u|
  #     u.completed_freestyles.count
  #   }
  #   @least_frees_played = @sorted_completed_freestyles.take(5)
  #   @most_frees_played = @sorted_completed_freestyles.reverse.take(5)
  # end

  def index
    @classroom = if params[:classroom_id]
                   Classroom.find(params[:classroom_id])
                 else
                   current_user.classrooms.first
                end
    @most_logins = @classroom.students.most_logins.limit(10).map { |u| [u.username, u.num_logins] }
    @least_logins = @classroom.students.least_logins.limit(10).map { |u| [u.username, u.num_logins] }
    @sorted_time_spent = @classroom.students.sort_by { |u| u.time_spent_playing }
    @least_time_spent = @sorted_time_spent.take(5).map { |u| [u.username, u.time_spent_playing] }
    @most_time_spent = @sorted_time_spent.reverse.take(5).map { |u| [u.username, u.time_spent_playing] }

    respond_to do |format|
      format.html
      format.js
    end
  end
end
