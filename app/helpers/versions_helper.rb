module VersionsHelper
  def latest_version
    Version.first unless Version.first.nil?
  end

  def version_display_name
    "Version #{latest_version.number}"
  end

  def latest_version_description
    latest_version.description
  end

  def display_stars(total_avg_rating)
    "★" * total_avg_rating
  end
end
