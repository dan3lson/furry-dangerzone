namespace :update do
  desc "Update User#user_words_count cached counter."
  task :user_user_words_cached_counter => :environment do
    User.find_each { |user| User.reset_counters(user.id, :user_words) }
  end
end
