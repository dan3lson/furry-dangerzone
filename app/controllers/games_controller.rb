class GamesController < ApplicationController
  def fundamentals
    @word = Word.find(params[:word_id])
    @synonyms = @word.synonyms if @word.has_synonyms?
    @antonyms = @word.antonyms if @word.has_antonyms?
    @real_world_examples = RealWorldExample.provide(@word.name)
  end

  def jeopardy
  end

  def leaderboard
    @gold_user = User.top_ten_highest_points[0]
    @silver_user = User.top_ten_highest_points[1]
    @bronze_user = User.top_ten_highest_points[2]
    @seven_through_ten_users = User.top_ten_highest_points.drop(3)
  end
end
