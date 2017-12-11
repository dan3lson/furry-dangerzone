class School::ExampleNonExamplesController < BaseSchoolController
  def index
    @example_non_examples = current_user.example_non_examples.show(:updated_at, :desc)
  end

  def new
    @e_non_e = ExampleNonExample.new
    @word = Word.find(params[:word_id])
  end

  def create
    @e_non_e = ExampleNonExample.new(example_non_example_params)
    @word = Word.find(params[:word_id])
    @e_non_e.user = current_user
    @e_non_e.word = @word

    if @e_non_e.save(example_non_example_params)
      flash[:success] = "Successfully created content for #{@word.name} word."
      redirect_to school_example_non_examples_path
    else
      flash[:danger] = "Sorry, creating #{@word.name} didn\'t work. Please try again."
      render :new
    end
  end

  def edit
    @e_non_e = ExampleNonExample.find(params[:id])
    @word = @e_non_e.word
  end

  def update
    @e_non_e = ExampleNonExample.find(params[:id])
    @word = Word.find(params["word_id"])

    if @e_non_e.update(example_non_example_params)
      flash[:success] = "You successfully updated content for #{@word.name}."
      redirect_to school_example_non_examples_path
    else
      flash[:danger] = "Sorry, updating #{@word.name} didn\'t work. ry again."
      render :edit
    end
  end

  def destroy
    @e_non_e = ExampleNonExample.find(params[:id])
    @word = Word.find(params[:word_id])

    if @e_non_e.destroy
      flash[:success] = "You successfully deleted content for #{@word.name}."
      redirect_to school_example_non_examples_path
    else
      flash[:danger] = "Sorry, deleting #{@word.name} didn\'t work. Please try again."
      render :edit
    end
  end

  def second_grade
    @e_non_e = ExampleNonExample.new
    @second_grade_words = Word.second_grade_hsb_2
  end

  def fourth_grade
    @e_non_e = ExampleNonExample.new
    @fourth_grade_words = Word.fourth_grade_hsb_2
  end

  def fifth_grade
    @e_non_e = ExampleNonExample.new
    @fifth_grade_words = Word.fifth_grade_hsb_2
  end

  def sixth_grade
    @e_non_e = ExampleNonExample.new
    @sixth_grade_words = Word.sixth_grade_hsb_2
  end

  private

  def example_non_example_params
    params.require(:example_non_example).permit(
      :text,
      :answer,
      :feedback
    )
  end
end
