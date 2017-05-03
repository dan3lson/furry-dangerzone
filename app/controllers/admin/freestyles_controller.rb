class Admin::FreestylesController < BaseAdminController
  def index
    @freestyles = Freestyle.unreviewed.latest.page(params[:page])
    @freestyle_count = Freestyle.unreviewed.count
  end
end
