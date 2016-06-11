module ApplicationHelper
  def full_header(header)
    if header.empty?
      header = ""
    else
      header
    end
  end

  def page_is_landing_page?
    params[:action] == "english_language_learners"
  end
end
