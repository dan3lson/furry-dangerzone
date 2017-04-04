class Admin::TagsController < BaseAdminController
  def index
    @tags = Tag.page(params[:page])
    @tag_count = Tag.count
  end

  def show
    @tag = Tag.find(params[:id])
  end
end
