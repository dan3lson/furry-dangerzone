class School::ResetPasswordsController < BaseSchoolController
  def update
    @student = Student.find(params[:id])
    @updated = @student.update_attributes(
      password: "leksi#{Date.today.year}",
      password_confirmation: "leksi#{Date.today.year}"
    )

    respond_to do |format|
      format.js { render template: "school/students/reset_password.js.erb" }
    end
  end
end
