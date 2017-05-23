class Admin::FreestylesController < BaseAdminController
  def index
    @freestyles = Freestyle.unreviewed.latest.page(params[:page])
    @freestyle_count = Freestyle.unreviewed.count
  end

  def destroy
    @freestyle = Freestyle.find(params[:id])

    if @freestyle.destroy
      flash[:success] = "Freestyle deleted successfully."
    else
      flash.now[:danger] = "Freestyle not deleted."
    end
    redirect_to admin_freestyles_path
  end
end
