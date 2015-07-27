module ReviewsHelper
  def there_are_any_reviews?
    !Review.first.nil?
  end

  def user_already_reviewed_latest_version?
    !Review.find_by(
      user: current_user,
      version: Version.first
    ).nil?
  end
end
