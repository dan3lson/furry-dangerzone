module ApplicationHelper
  def full_header(header)
    if header.empty?
      header = ""
    else
      header
    end
  end

  def action?(params_action)
    params[:action] == params_action
  end

  def controller?(params_controller)
    params[:controller] == params_controller
  end
end
