class Admin::WordsController < BaseAdminController
  def index
    @words = Word.page(params[:page])
  end

  def show
    @word = Word.find(params[:id])
  end
end
