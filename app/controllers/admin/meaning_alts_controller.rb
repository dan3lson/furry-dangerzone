class Admin::MeaningAltsController < BaseAdminController
	def index
    @filter = params[:filter]
		@meaning_alts_count = MeaningAlt.count

		# Group by name and then display each card text partial as a card block for
		# better editing and deleting

    if @filter
      if @filter == "latest"
        @m_a_groups = MeaningAlt.includes(:word, :creator)
																.order("created_at DESC")
																.group_by { |m_a| m_a.word.id }
      end
    else
      @m_a_groups = MeaningAlt.includes(:word, :creator)
															.order("words.name ASC")
															.group_by { |m_a| m_a.word.id }
    end
  end
end
