class BlogsController < ApplicationController
  layout "application_guest"

  def index
  end

  def show
    render template: "blogs/#{params[:title]}"
  end
end
