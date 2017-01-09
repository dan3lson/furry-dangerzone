class Admin::WordsController < BaseAdminController
  def index
    @words = Word.paginate(:page => params[:page], per_page: 100)
  end

  def show
    @word = Word.find(params[:id])
  end
end
