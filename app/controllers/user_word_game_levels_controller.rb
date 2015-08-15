class UserWordGameLevelsController < ApplicationController
  def update
    puts "WORD: #{Word.all}"
    @word = Word.find(params[:word_id])
    @level = Level.find(params[:level_id])
    @game = Game.find_by(name: params[:game_name])
    @user_word = UserWord.find_by(user: current_user, word: @word)
    @game_level = GameLevel.find_by(
      game: @game,
      level: @level
    )
    @user_word_game_level = UserWordGameLevel.find_by(
      user_word: @user_word,
      game_level: @game_level
    )

    @user_word_game_level.status = "complete"

    if @user_word_game_level.save
      render json: {
        status: "UWGL: #{@user_word_game_level.id} updated successfully"
      }
    else
      render json: {
        status: "UWGL: #{@user_word_game_level.id} not updated successfully"
      }
    end
  end
end
