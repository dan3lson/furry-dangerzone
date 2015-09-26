module ApplicationHelper
  def full_title(title)
    if title.empty?
      title = "Leksi"
    else
      "Leksi | " << title
    end
  end

  def full_header(header)
    if header.empty?
      header = ""
    else
      header
    end
  end

  def right_header_button(value, path)
    content_tag(:span, class: "pull-right") do
      content_tag(:a)
    end
  end
end
