class School::ExampleNonExamplesController < BaseSchoolController
  before_action :logged_in_user
  before_action :correct_user, only: [:new, :create, :edit, :update]

  def new
    @e_non_e = ExampleNonExample.new
  end

  def create
    @e_non_e = ExampleNonExample.new(example_non_example_params)
    @word = Word.find(params[:word_id])
    @saved = false

    if @e_non_e.save
      @e_non_e.words << @word
      @saved = true
    else
      @saved = false
      @errors = @e_non_e.errors.full_messages
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def example_non_example_params
    params.require(:example_non_example).permit(
      :text,
      :answer,
      :feedback
    )
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in first to do that."
      redirect_to login_url
    end
  end

  def correct_user
    unless current_user.can_create_example_non_examples?
      flash[:danger] = "That\'s not something you can do."
      redirect_to menu_path
    end
  end
end
