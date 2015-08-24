class UserPointsController < ApplicationController
  def update
    @points = params[:points]

    current_user.points += @points

    if current_user.save
      render json: {
        errors: "No errors",
        status: "#{current_user.username}\'s points successfully modified"
      }
    else
      render json: {
        errors: current_user.errors.full_messages,
        status: "#{current_user.username}\'s points not successfully modified"
      }
    end
  end
end
