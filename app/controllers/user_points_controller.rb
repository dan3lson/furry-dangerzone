class UserPointsController < ApplicationController
  def update
    @points = params[:points].to_i
    current_user.points += @points

    if current_user.save
      render json: {
        response: "Success: #{current_user.username} points updated."
      }
    else
      msg = "#{current_user.username}\'s points (#{@points}) not updated."
      render json: { error: current_user.errors.full_messages << msg }
    end
  end
end
