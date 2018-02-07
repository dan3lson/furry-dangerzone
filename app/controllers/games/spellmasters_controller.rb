class Games::SpellmastersController < ApplicationController
  def index
    @target_word = Word.find(current_user.words.pluck(:id).shuffle.first)
    @user_word = UserWord.object(current_user, @target_word)

    respond_to do |format|
      format.js { render template: "games/spellmasters/play.js.erb" }
    end
  end
end
