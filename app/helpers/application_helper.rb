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
      header = image_tag("Leksi.png")
    else
      header
    end
  end

  def right_header_button(value, path)
    content_tag(:span, class: "float-right") do
      content_tag(:a)
    end
  end
end
