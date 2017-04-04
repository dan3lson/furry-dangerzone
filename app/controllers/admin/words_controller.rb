class Admin::WordsController < BaseAdminController
  def index
    @words = Word.page(params[:page])
    @word_count = Word.count
  end

  def show
    @word = Word.find(params[:id])
  end
end
