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
end
