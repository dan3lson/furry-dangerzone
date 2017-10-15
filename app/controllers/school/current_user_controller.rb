class School::CurrentUserController < BaseSchoolController
  def home
  end

  def messages
    # Removed all and have to redo
  end

  def settings
  end

  def content
    @words = current_user.created_words
  end

  def my_meaning_alts
    @m_a_groups = current_user.meaning_alts
                              .includes(:word, :creator)
                              .order("created_at DESC")
                              .group_by { |m_a| m_a.word.id }
  end
end
