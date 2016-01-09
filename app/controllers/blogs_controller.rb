class BlogsController < ApplicationController
  layout "public_application"

  def index
  end

  def show
    render template: "blogs/#{params[:title]}"
  end
end
