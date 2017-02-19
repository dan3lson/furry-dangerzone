class UserPointsController < ApplicationController
  def update
    @points = params[:points].to_i
    current_user.points += @points

    if current_user.save
      render json: {
        errors: "Success: Points updated for #{current_user.username}."
      }
    else
      render json: {
        errors: current_user.errors.full_messages,
        status: "ERROR: #{current_user.username}\'s points not modified."
      }
    end
  end
end
