class Admin::FreestylesController < BaseAdminController
  def index
    @freestyles = Freestyle.unreviewed.latest.page(params[:page])
    @freestyle_count = Freestyle.count
  end
end
