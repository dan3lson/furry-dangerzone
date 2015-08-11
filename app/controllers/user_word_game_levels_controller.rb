class UserWordGameLevelsController < ApplicationController
  def update
    @word = Word.find(params[:word_id])
    @level = Level.find(params[:level_id])
    @fundamentals = Game.find_by(name: params[:game_name])
    @user_word = UserWord.find_by(user: current_user, word: @word)
    @game_level = GameLevel.find_by(
      game: @fundamentals,
      level: @level
    )
    @user_word_game_level = UserWordGameLevel.find_by(
      user_word: @user_word,
      game_level: @game_level
    )

    @user_word_game_level.status = "complete"

    if @user_word_game_level.save
      head :accepted
    else
      logger.error { "#{Time.now}/#{current_user}/#{@user_word_game_level}" }
      head :bad_request
    end
  end
end
